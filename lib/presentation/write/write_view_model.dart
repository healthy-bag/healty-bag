import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  final bool isLoading;
  final String? imagePath;
  final String? imageUrl;

  WriteState({this.isLoading = false, this.imagePath, this.imageUrl});

  WriteState copyWith({bool? isLoading, String? imagePath, String? imageUrl}) {
    return WriteState(
      isLoading: isLoading ?? this.isLoading,
      imagePath: imagePath ?? this.imagePath,
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

    state = state.copyWith(imagePath: xFile.path);
  }

  /// Firebase Storage에 이미지 업로드
  Future<void> uploadImage() async {
    if (state.imagePath == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now().microsecondsSinceEpoch}');

      await storageRef.putFile(File(state.imagePath!));
      final downloadUrl = await storageRef.getDownloadURL();

      state = state.copyWith(isLoading: false, imageUrl: downloadUrl);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose<WriteViewModel, WriteState>(
      WriteViewModel.new,
    );
