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
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 프로필 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage: feed.authorimageUrl.isNotEmpty
                      ? NetworkImage(feed.authorimageUrl)
                      : null,
                  child: feed.authorimageUrl.isEmpty
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feed.authorId.isNotEmpty ? feed.authorId : feed.uid,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          SizedBox(height: 10),
          // 이미지 영역
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1, // 정사각형 비율
                child: Image.network(
                  feed.fileUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                        child: Icon(Icons.error, color: Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 게시글 내용 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                    text: (feed.content.length > 30 || feed.content.contains('\n'))
                        ? feed.content.replaceAll('\n', ' ').substring(0, 30)
                        : feed.content,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  (feed.content.length > 20 || feed.content.contains('\n'))
                      ? const TextSpan(
                          text: '   ... 더보기',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      : const TextSpan(text: ''),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 액션 버튼 (좋아요, 댓글)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildActionIcon(
                  feed.isLiked ? Icons.favorite : Icons.favorite_border,
                  '${feed.likeCount}',
                  color: feed.isLiked ? Colors.red : Colors.black,
                  onTap: onLikeTap,
                ),
                const SizedBox(width: 20),
                _buildActionIcon(
                  Icons.chat_bubble_outline,
                  '${feed.commentCount}',
                  onTap: onCommentTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 작성 시간
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _formatCreatedAt(feed.createdAt),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatCreatedAt(String createdAt) {
    if (createdAt.isEmpty) return '방금 전';

    final dateTime = DateTime.tryParse(createdAt);
    if (dateTime == null) return createdAt;

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays <= 3) {
      // 24시간 이상 ~ 72시간(3일)까지 '일 전' 표시
      return '${difference.inDays}일 전';
    } else {
      // 3일(72시간) 이후로는 '년 월 일' 표시
      return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일';
    }
  }

  Widget _buildActionIcon(
    IconData icon,
    String label, {
    Color color = Colors.black,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
