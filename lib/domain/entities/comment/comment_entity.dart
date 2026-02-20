class CommentEntity {
  final String commentId;
  final String feedId;
  final String uid;
  final String content;
  final DateTime timeAgo;
  final String nickname;
  final String authorImageUrl;
  final bool isLiked;
  final int likeCount;
  final String? parentId; // + 답글 기능을 위한 부모 댓글 ID

  CommentEntity({
    this.commentId = '',
    this.feedId = '',
    this.uid = '',
    required this.content,
    required this.timeAgo,
    required this.nickname,
    this.authorImageUrl = '',
    this.isLiked = false,
    this.likeCount = 0,
    this.parentId,
  });

  CommentEntity copyWith({
    String? commentId,
    String? feedId,
    String? uid,
    String? content,
    DateTime? timeAgo,
    String? nickname,
    String? authorImageUrl,
    bool? isLiked,
    int? likeCount,
    String? parentId,
  }) {
    return CommentEntity(
      commentId: commentId ?? this.commentId,
      feedId: feedId ?? this.feedId,
      uid: uid ?? this.uid,
      content: content ?? this.content,
      timeAgo: timeAgo ?? this.timeAgo,
      nickname: nickname ?? this.nickname,
      authorImageUrl: authorImageUrl ?? this.authorImageUrl,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      parentId: parentId ?? this.parentId,
    );
  }
}