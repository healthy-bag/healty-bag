import 'package:healthy_bag/core/di/repository_di/auth_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/comment_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_view_model.g.dart';

@riverpod
class CommentViewModel extends _$CommentViewModel {
  @override
  // + 답글 기능 구현을 위한 댓글 상태 정의
  CommentState build() {
    return const CommentState();
  }

  void updateCommentText(String value) {
    state = state.copyWith(content: value);
  }

  // 답글 모드 설정
  void setReplyTarget(CommentEntity? target) {
    state = state.copyWith(
      parentComment: target,
      editingComment: null,
      content: target != null ? '' : state.content,
    );
  }

  // 수정 모드 설정
  void setEditTarget(CommentEntity? target) {
    state = state.copyWith(
      editingComment: target,
      parentComment: null,
      content: target?.content ?? '',
    );
  }

  Future<void> deleteComment(String commentId) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    await commentRepository.deleteComment(commentId);
  }

  Future<void> submitComment(String feedId) async {
    if (state.isLoading) return;

    final commentText = state.content.trim();
    if (commentText.isEmpty) return;

    state = state.copyWith(isLoading: true);

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final userRepository = ref.read(userRepositoryProvider);
      final commentRepository = ref.read(commentRepositoryProvider);

      final uid = await authRepository.getCurrentUid();
      if (uid == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      // 수정 모드인 경우
      if (state.editingComment != null) {
        await commentRepository.updateComment(
          state.editingComment!.commentId,
          commentText,
        );
        state = const CommentState();
        return;
      }

      // 새 댓글 또는 답글 작성
      final userInfo = await userRepository.getUserInfo(uid);
      if (userInfo == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final newComment = CommentEntity(
        feedId: feedId,
        uid: uid,
        content: commentText,
        timeAgo: DateTime.now(),
        nickname: userInfo.nickname,
        authorImageUrl: userInfo.profileUrl ?? '',
        parentId: state.parentComment?.commentId,
      );

      await commentRepository.addComment(newComment);
      state = const CommentState(); // 전송 후 초기화
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

// + 답글 기능 구현을 위한 댓글 상태 클래스
// ++ isLoading 추가
class CommentState {
  final String content;
  final CommentEntity? parentComment;
  final CommentEntity? editingComment;
  final bool isLoading;

  const CommentState({
    this.content = '',
    this.parentComment,
    this.editingComment,
    this.isLoading = false,
  });

  CommentState copyWith({
    String? content,
    Object? parentComment = _sentinel,
    Object? editingComment = _sentinel,
    bool? isLoading,
  }) {
    return CommentState(
      content: content ?? this.content,
      parentComment: parentComment == _sentinel
          ? this.parentComment
          : (parentComment as CommentEntity?),
      editingComment: editingComment == _sentinel
          ? this.editingComment
          : (editingComment as CommentEntity?),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();
