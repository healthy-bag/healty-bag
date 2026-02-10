import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/comment/widgets/comment_model.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 이미지
          CircleAvatar(radius: 18, backgroundColor: Colors.grey[300]),
          const SizedBox(width: 12),
          // 댓글 내용 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comment.nickname,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                // 댓글 본문 추가
                Text(
                  widget.comment.content,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${widget.comment.timeAgo.year}.${widget.comment.timeAgo.month}.${widget.comment.timeAgo.day}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '답글 달기',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 좋아요 아이콘, 숫자
          Column(
            children: [
             IconButton(
              constraints: BoxConstraints(), // 아이콘 버튼 여백 최소화
              padding: EdgeInsets.zero,
              icon: Icon(
                widget.comment.isLiked ? Icons.favorite : Icons.favorite_border,
                color: widget.comment.isLiked ? Colors.pinkAccent : Colors.grey,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  widget.comment.isLiked = !widget.comment.isLiked;
                  widget.comment.isLiked
                  ? widget.comment.likeCount ++
                  : widget.comment.likeCount --;
                });
              }, 
              ),
              Text('${widget.comment.likeCount}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    );
  }
}