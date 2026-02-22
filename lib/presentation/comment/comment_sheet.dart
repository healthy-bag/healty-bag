import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/presentation/comment/widgets/comment_item.dart';
import 'package:healthy_bag/presentation/comment/comment_view_model.dart';
import 'package:healthy_bag/presentation/home/home_view_model.dart';

// 하단에 올라오는 전체 댓글창
class CommentSheet extends ConsumerStatefulWidget {
  final String feedId;
  const CommentSheet({super.key, required this.feedId});

  @override
  // + ConsumerStatefulWidget으로 수정
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(feedCommentsProvider(widget.feedId));
    final commentViewModel = ref.watch(commentViewModelProvider);

    // 수정 모드 진입 시 텍스트 필드 자동 입력
    ref.listen(commentViewModelProvider.select((s) => s.editingComment), (prev, next) {
      if (next != null && prev?.commentId != next.commentId) {
        _controller.text = next.content;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      } else if (next == null && prev != null) {
        // 수정 취소 시 입력창 초기화 (필요한 경우)
        _controller.clear();
      }
    });

    // 답글 모드 진입 시 텍스트 필드 초기화
    ref.listen(commentViewModelProvider.select((s) => s.parentComment), (prev, next) {
      if (next != null && prev?.commentId != next.commentId) {
        _controller.clear();
      }
    });

    // 댓글창 스와이프 가능하도록 구현 + 댓글 창 높이 조절
    return DraggableScrollableSheet(
      initialChildSize: 0.6, // 처음 댓글창 높이 (화면의 50%)
      minChildSize: 0.4, // 최소 높이 (화면의 40%)
      // maxChildSize: 0.95, // 최대 높이 (화면의 95%)
      expand: false, 
      builder: (context, scrollController) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // 화면 터치시 키보드 내려감
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                // 핸들바 (스와이프 힌트): 유저에게 끌어올릴 수 있음을 알림
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    '댓글',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                // 댓글 리스트
                Expanded(
                  child: commentsAsync.when(
                    data: (comments) {
                      if (comments.isEmpty) {
                        return const Center(child: Text('댓글이 없습니다'));
                      }
                      
                      // +댓글 트리 구조 생성 (부모 댓글 아래에 자식 댓글 배치)
                      // parentId가 null이거나 빈 문자열이면 부모 댓글로 간주
                      final parentComments = comments.where((c) => c.parentId == null || c.parentId!.isEmpty).toList();
                      final childComments = comments.where((c) => c.parentId != null && c.parentId!.isNotEmpty).toList();
                      
                      final List<CommentEntity> sortedComments = [];
                      for (var parent in parentComments) {
                        sortedComments.add(parent);
                        // 해당 부모의 자식들만 필터링하여 바로 뒤에 추가
                        sortedComments.addAll(childComments.where((c) => c.parentId == parent.commentId));
                      }
                      
                      // 혹시 기존 댓글이 삭제되기 전 답글을 달았는데, 기존 댓글을 삭제하더라도 답글은 남아있을 수 있도록 설정
                      final addedIds = sortedComments.map((c) => c.commentId).toSet();
                      final orphanComments = comments.where((c) => !addedIds.contains(c.commentId)).toList();
                      sortedComments.addAll(orphanComments);

                      return ListView.builder(
                        controller: scrollController,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: sortedComments.length,
                        itemBuilder: (context, index) {
                          final comment = sortedComments[index];
                          return CommentItem(
                            comment: comment,
                            isReply: comment.parentId != null,
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('댓글 로딩 에러: $err')),
                  ),
                ),
                // +답글/수정 모드 표시기
                if (commentViewModel.parentComment != null || commentViewModel.editingComment != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.grey[100],
                    child: Row(
                      children: [
                        Icon(
                          commentViewModel.editingComment != null ? Icons.edit : Icons.reply,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            commentViewModel.editingComment != null
                                ? '댓글 수정 중...'
                                : '${commentViewModel.parentComment!.nickname}님에게 답글 남기는 중...',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (commentViewModel.editingComment != null) {
                              ref.read(commentViewModelProvider.notifier).setEditTarget(null);
                              _controller.clear();
                            } else {
                              ref.read(commentViewModelProvider.notifier).setReplyTarget(null);
                            }
                          },
                          child: const Icon(Icons.close, size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                // 하단 입력창
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 15,
                    bottom: MediaQuery.of(context).padding.bottom +
                        MediaQuery.of(context).viewInsets.bottom +
                        20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, -2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            ref
                                .read(commentViewModelProvider.notifier)
                                .updateCommentText(value);
                          },
                          decoration: InputDecoration(
                            hintText: '댓글을 입력해주세요...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 전송 버튼 : 입력 내용이 없거나 제출 중이면 비활성화
                      IconButton(
                        icon: commentViewModel.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                                ),
                              )
                            : Icon(
                                commentViewModel.editingComment != null
                                    ? Icons.check_circle
                                    : Icons.send_rounded,
                                color: commentViewModel.content.trim().isEmpty
                                    ? Colors.grey[400]
                                    : Colors.pinkAccent,
                              ),
                        onPressed: commentViewModel.content.trim().isEmpty || commentViewModel.isLoading
                            ? null
                            : () async {
                                await ref
                                    .read(commentViewModelProvider.notifier)
                                    .submitComment(widget.feedId);
                                if (mounted) {
                                  _controller.clear();
                                  FocusScope.of(context).unfocus();
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}