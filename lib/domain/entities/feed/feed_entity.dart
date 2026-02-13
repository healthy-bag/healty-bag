class FeedEntity {
  final String uid;
  final String feedId;
  final String fileUrl;
  final int likeCount;
  final int commentCount;
  final String thumbnailUrl;
  final String createdAt;

  FeedEntity({
    required this.uid,
    required this.feedId,
    required this.fileUrl,
    required this.likeCount,
    required this.commentCount,
    required this.thumbnailUrl,
    required this.createdAt,
  });

  // 데이터 수정을 위한 copyWith
  FeedEntity copyWith({
    String? uid,
    String? feedId,
    String? fileUrl,
    int? likeCount,
    int? commentCount,
    String? thumbnailUrl,
    String? createdAt,
  }) {
    return FeedEntity(
      uid: uid ?? this.uid,
      feedId: feedId ?? this.feedId,
      fileUrl: fileUrl ?? this.fileUrl,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
