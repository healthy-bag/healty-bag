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

  // JSON -> Entity 변환 (기존 프로젝트 패턴 유지)
  factory FeedEntity.fromJson(Map<String, dynamic> json) {
    return FeedEntity(
      uid: json['uid'] as String,
      feedId: json['feedId'] as String,
      fileUrl: json['fileUrl'] as String,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  // Entity -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'feedId': feedId,
      'fileUrl': fileUrl,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt,
    };
  }

  // 데이터 수정을 위한 copyWith (권장)
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
