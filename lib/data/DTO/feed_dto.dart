// 게시물 데이터 모델
class FeedDTO {
  final String uid;
  final String feedId;
  final String fileUrl;
  final int likeCount; // 컨셉에 맞게 변경 가능, 내가 좋아요를 눌렀는지 알 수 없음 -> 별로 컬렉션
  final int commentCount; // 컨셉에 맞게 변경 가능
  final String thumbnailUrl;
  final String createdAt;

  FeedDTO({
    required this.uid,
    required this.feedId,
    required this.fileUrl,
    required this.likeCount,
    required this.commentCount,
    required this.thumbnailUrl,
    required this.createdAt,
  });
}
