// 피드 데이터 모델

class FeedEntity {
  // 작성자 id, 다른 id, 이미지 url, 내용, 좋아요, 댓글, 생성ㅇ시간
  final String id;
  final String authorId;
  final String authorimageUrl;
  final String imageUrl;
  final String content;
  final int likes;
  final int comments;
  final DateTime updatedAt;
  final bool isLiked;

  FeedEntity({
    required this.id,
    required this.authorId,
    required this.authorimageUrl,
    required this.imageUrl,
    required this.content,
    required this.likes,
    required this.comments,
    required this.updatedAt,
    this.isLiked = false,
  });
}
