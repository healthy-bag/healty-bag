import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/di/repository_di/auth_repository_di.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/presentation/comment/comment_view_model.dart';

class CommentItem extends ConsumerStatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
    this.isReply = false,
  });

  final CommentEntity comment;
  final bool isReply;

  @override
  ConsumerState<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends ConsumerState<CommentItem> {
  late bool _isLiked;
  late int _likeCount;
  String? _currentUid;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.comment.isLiked;
    _likeCount = widget.comment.likeCount;
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final auth = ref.read(authRepositoryProvider);
    final uid = await auth.getCurrentUid();
    if (mounted) {
      setState(() {
        _currentUid = uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthor = _currentUid == widget.comment.uid;

    return Padding(
      padding: EdgeInsets.only(
        left: widget.isReply ? 48.0 : 16.0,
        right: 16.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 이미지
          CircleAvatar(
            radius: widget.isReply ? 14 : 18,
            backgroundColor: Colors.grey[300],
            backgroundImage: widget.comment.authorImageUrl.isNotEmpty
                ? NetworkImage(widget.comment.authorImageUrl)
                : null,
            child: widget.comment.authorImageUrl.isEmpty
                ? Icon(Icons.person, color: Colors.white, size: widget.isReply ? 16 : 20)
                : null,
          ),
          const SizedBox(width: 12),
          // 댓글 내용 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.comment.nickname,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTimeAgo(widget.comment.timeAgo),
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.comment.content,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(commentViewModelProvider.notifier)
                            .setReplyTarget(widget.comment);
                      },
                      child: Text(
                        '답글 달기',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (isAuthor) ...[
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(commentViewModelProvider.notifier)
                              .setEditTarget(widget.comment);
                        },
                        child: Text(
                          '수정',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _showDeleteDialog(context),
                        child: Text(
                          '삭제',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // 좋아요 영역
          Column(
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.pinkAccent : Colors.grey,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                    _isLiked ? _likeCount++ : _likeCount--;
                  });
                },
              ),
              Text(
                '$_likeCount',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('댓글 삭제'),
        content: const Text('정말로 이 댓글을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(commentViewModelProvider.notifier)
                  .deleteComment(widget.comment.commentId);
              Navigator.pop(context);
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return '방금 전';
    if (difference.inMinutes < 60) return '${difference.inMinutes}분 전';
    if (difference.inHours < 24) return '${difference.inHours}시간 전';
    if (difference.inDays <= 3) return '${difference.inDays}일 전';
    return '${dateTime.year}.${dateTime.month}.${dateTime.day}';
  }
}