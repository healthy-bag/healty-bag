import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/core/di/usecase_di/feed_usecase_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  final bool isLoading;
  final String? imagePath;
  final String? imageUrl;
  final String content;
  final String tag;

  WriteState({
    this.isLoading = false,
    this.imagePath,
    this.imageUrl,
    this.content = '',
    this.tag = '',
  });

  WriteState copyWith({
    bool? isLoading,
    String? imagePath,
    String? imageUrl,
    String? content,
    String? tag,
  }) {
    return WriteState(
      isLoading: isLoading ?? this.isLoading,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      tag: tag ?? this.tag,
    );
  }
}

class WriteViewModel extends Notifier<WriteState> {
  final contentController = TextEditingController();
  final tagController = TextEditingController();
  @override
  WriteState build() {
    ref.onDispose(() {
      contentController.dispose();
      tagController.dispose();
    });
    return WriteState();
  }

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateTag(String tag) {
    state = state.copyWith(tag: tag);
  }

  /// 갤러리에서 이미지 선택 (로컬 경로만 저장)
  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;

    state = state.copyWith(imagePath: xFile.path);
  }

  // 사진 업로드 + Firestore 데이터 저장 통합 로직
  Future<void> uploadFeed() async {
    if (state.imagePath == null) return;
    state = state.copyWith(isLoading: true);
    try {
      final feedUseCase = ref.read(feedUseCaseProvider);
      await feedUseCase.execute(
        uid: 'uid',
        feedId: '',
        imageFile: File(state.imagePath!),
        content: state.content,
        tag: state.tag,
        likeCount: 0,
        commentCount: 0,
        thumbnailUrl: '',
        createdAt: DateTime.now().toIso8601String(),
      );
      contentController.clear();
      tagController.clear();
      state = WriteState();
      // state = state.copyWith(isLoading: false);
      // TODO: 성공 후 페이지 이동 로직 추가 (Context 필요시 View에서 처리)
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('업로드 실패: $e');
      rethrow; // UI에서 catch 할 수 있도록 에러를 다시 던집니다.
    }
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose<WriteViewModel, WriteState>(
      WriteViewModel.new,
    );
