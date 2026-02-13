import 'package:flutter/material.dart';
import 'package:healthy_bag/domain/entities/feed/feed_entity.dart';

class FeedItemWidget extends StatelessWidget {
  final FeedEntity feed;
  final VoidCallback onCommentTap;

  const FeedItemWidget({
    super.key,
    required this.feed,
    required this.onCommentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지 (Entity imagUrl 사용)
        SizedBox.expand(
          child: Image.network(
            feed.fileUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, StackTrace) =>
                const Center(child: Icon(Icons.error, color: Colors.white)),
          ),
        ),
        // 하단 콘텐츠 영역 (상대방 프로필)
        Positioned(
          bottom: 80,
          left: 20,
          child: Row(
            children: [
              // CircleAvatar(
              //   radius: 20,
              //   backgroundImage: NetworkImage(feed.),
              // ),
              SizedBox(width: 12),
              Text(
                feed.uid,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // 하단 콘텐츠 영역 (Entity content 사용)
        // Positioned(
        //   bottom: 40,
        //   left: 16,
        //   child: Text(
        //     feed.content,
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // 우측 액션 버튼들 (Entity likes, comments 사용)
        Positioned(
          right: 16,
          bottom: 150,
          child: Column(
            children: [
              // _buildIcon(
              //   feed.isLiked ? Icons.favorite : Icons.favorite_border,
              //   '${feed.likeCount}',
              //   color: feed.isLiked ? Colors.pinkAccent : Colors.white,
              // ),
              SizedBox(height: 20),
              // _buildIcon(
              //   Icons.chat_bubble_outline,
              //   '${feed.comments}',
              //   onTap: onCommentTap,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(
    IconData icon,
    String label, {
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap ?? () {},
          icon: Icon(icon, color: color, size: 40),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
