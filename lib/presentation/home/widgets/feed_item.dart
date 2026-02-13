import 'package:flutter/material.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';

class FeedItemWidget extends StatelessWidget {
  final FeedEntity feed;
  final VoidCallback onCommentTap;
  final VoidCallback onLikeTap;

  const FeedItemWidget({
    super.key,
    required this.feed,
    required this.onCommentTap,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        SizedBox.expand(
          child: Image.network(
            feed.fileUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error, color: Colors.white)),
          ),
        ),
        // 하단 콘텐츠 영역 (작성자 프로필)
        Positioned(
          bottom: 80,
          left: 20,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: feed.authorimageUrl.isNotEmpty
                    ? NetworkImage(feed.authorimageUrl)
                    : null,
                child: feed.authorimageUrl.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                feed.authorId.isNotEmpty ? feed.authorId : feed.uid,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // 하단 콘텐츠 영역 (게시물 내용)
        Positioned(
          bottom: 40,
          left: 16,
          child: Text(
            feed.content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 우측 액션 버튼들
        Positioned(
          right: 16,
          bottom: 150,
          child: Column(
            children: [
              _buildIcon(
                feed.isLiked ? Icons.favorite : Icons.favorite_border,
                '${feed.likeCount}',
                color: feed.isLiked ? Colors.pinkAccent : Colors.white,
                onTap: onLikeTap,
              ),
              const SizedBox(height: 20),
              _buildIcon(
                Icons.chat_bubble_outline,
                '${feed.commentCount}',
                onTap: onCommentTap,
              ),
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
