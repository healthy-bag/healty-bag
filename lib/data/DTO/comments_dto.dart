class CommentsDTO {
  final String uid;
  final String feedId;
  final String nickname;
  final String comment;
  final String createdAt;

  CommentsDTO({
    required this.uid,
    required this.feedId,
    required this.nickname,
    required this.comment,
    required this.createdAt,
  });
}
