import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';

class CommentsDTO {
  final String id;
  final String uid;
  final String feedId;
  final String nickname;
  final String comment;
  final String createdAt;

  CommentsDTO({
    required this.id,
    required this.uid,
    required this.feedId,
    required this.nickname,
    required this.comment,
    required this.createdAt,
  });

  factory CommentsDTO.fromJson(Map<String, dynamic> json) {
    return CommentsDTO(
      id: json['id'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      feedId: json['feedId'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'feedId': feedId,
      'nickname': nickname,
      'comment': comment,
      'createdAt': createdAt,
    };
  }

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: id,
      uid: uid,
      feedId: feedId,
      nickname: nickname,
      content: comment,
      timeAgo: DateTime.parse(createdAt),
      isLiked: false, // 기본값
      likeCount: 0, // 기본값
    );
  }

  factory CommentsDTO.fromEntity(CommentEntity entity) {
    return CommentsDTO(
      id: entity.commentId,
      uid: entity.uid,
      feedId: entity.feedId,
      nickname: entity.nickname,
      comment: entity.content,
      createdAt: entity.timeAgo.toIso8601String(),
    );
  }
}
