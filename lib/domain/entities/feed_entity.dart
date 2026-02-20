class FeedEntity {
  final String uid;
  final String feedId;
  final String fileUrl;
  final String content;
  final int likeCount;
  final int commentCount;
  final String thumbnailUrl;
  final String tag;
  final String createdAt;
  final String deletedAt;
  final bool isLiked; // 좋아요 여부 추가
  final String authorId; // 작성자 ID (닉네임 등) 추가
  final String authorimageUrl; // 작성자 이미지 추가

  FeedEntity({
    required this.uid,
    required this.feedId,
    required this.fileUrl,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.thumbnailUrl,
    required this.tag,
    required this.createdAt,
    required this.deletedAt,
    this.isLiked = false,
    this.authorId = '',
    this.authorimageUrl = '',
  });

  // 데이터 수정을 위한 copyWith (권장)
  FeedEntity copyWith({
    String? uid,
    String? feedId,
    String? fileUrl,
    String? content,
    int? likeCount,
    int? commentCount,
    String? thumbnailUrl,
    String? tag,
    String? createdAt,
    String? deletedAt,
    bool? isLiked,
    String? authorId,
    String? authorimageUrl,
  }) {
    return FeedEntity(
      uid: uid ?? this.uid,
      feedId: feedId ?? this.feedId,
      fileUrl: fileUrl ?? this.fileUrl,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      tag: tag ?? this.tag,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isLiked: isLiked ?? this.isLiked,
      authorId: authorId ?? this.authorId,
      authorimageUrl: authorimageUrl ?? this.authorimageUrl,
    );
  }
}
