
import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/comment/widgets/comment_item.dart';
import 'package:healthy_bag/presentation/comment/widgets/comment_model.dart';

// 하단에 올라오는 전체 댓글창
class CommentSheet extends StatelessWidget{
  CommentSheet({super.key});

  // 임시 댓글 데이터
  final List<Comment> comments = [
    Comment(nickname: 'jiii12', content: '오운완', timeAgo: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(2)
          ),
        ),
        Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 10),
        child: Text('댓글', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        ),
        // 댓글 리스트
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return CommentItem(comment: comment);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 10,
            bottom: MediaQuery.of(context).padding.bottom +
                MediaQuery.of(context).viewInsets.bottom +
                10,
          ),
          decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
          child: Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: Colors.grey[300]),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '댓글을 입력해주세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.send, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}