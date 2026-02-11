import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class NicknameState {
  final String nickname;
  final bool isLoading;
  final bool isValid;
  final String? imagePath;
  final String? imageUrl;

  NicknameState({
    this.nickname = '',
    this.isLoading = false,
    this.isValid = false,
    this.imagePath,
    this.imageUrl,
  });

  NicknameState copyWith({
    String? nickname,
    bool? isLoading,
    bool? isValid,
    String? imagePath,
    String? imageUrl,
  }) {
    return NicknameState(
      nickname: nickname ?? this.nickname,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class NicknameViewModel extends Notifier<NicknameState> {
  @override
  NicknameState build() {
    return NicknameState();
  }

  void setNickname(String value) {
    int letterCount = value.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    bool hasNumber = value.contains(RegExp(r'[0-9]'));
    final isValid = letterCount >= 3 && hasNumber;
    state = state.copyWith(nickname: value, isValid: isValid);
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    state = state.copyWith(imagePath: xFile.path);
  }

  Future<void> uploadImage() async {
    if (state.imagePath == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().microsecondsSinceEpoch}');

      await storageRef.putFile(File(state.imagePath!));
      final downloadUrl = await storageRef.getDownloadURL();

      state = state.copyWith(isLoading: false, imageUrl: downloadUrl);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // TODO: 에러 처리 개선 (사용자에게 알림 표시)
      print('업로드 실패: $e');
    }
  }
}

final nicknameViewModelProvider =
    NotifierProvider.autoDispose<NicknameViewModel, NicknameState>(() {
      return NicknameViewModel();
    });
