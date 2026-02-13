
// 댓글에 들어갈 데이터 (닉네임, 내용, 좋아요, 좋아요수, 작성시간)
class CommentEntity {
  CommentEntity({
    required this.nickname,
    required this.content,
    this.isLiked = false,
    this.likeCount = 0,
    required this.timeAgo,
  });

  final String nickname;
  final String content;
  bool isLiked;
  int likeCount;
  DateTime timeAgo;
}