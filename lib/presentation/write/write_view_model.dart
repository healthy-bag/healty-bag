import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  final bool isLoading;
  final String? localPath;
  final String? imageUrl;

  WriteState({this.isLoading = false, this.localPath, this.imageUrl});

  WriteState copyWith({bool? isLoading, String? localPath, String? imageUrl}) {
    return WriteState(
      isLoading: isLoading ?? this.isLoading,
      localPath: localPath ?? this.localPath,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class WriteViewModel extends Notifier<WriteState> {
  @override
  WriteState build() {
    return WriteState();
  }

  /// 갤러리에서 이미지 선택 (로컬 경로만 저장)
  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;

    state = state.copyWith(localPath: xFile.path);
  }

  /// Firebase Storage에 이미지 업로드
  Future<void> uploadImage() async {
    if (state.localPath == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now().microsecondsSinceEpoch}');

      await storageRef.putFile(File(state.localPath!));
      final downloadUrl = await storageRef.getDownloadURL();

      state = state.copyWith(isLoading: false, imageUrl: downloadUrl);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // TODO: 에러 처리 개선 (사용자에게 알림 표시)
      print('업로드 실패: $e');
    }
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose<WriteViewModel, WriteState>(
      WriteViewModel.new,
    );
