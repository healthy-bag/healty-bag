import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';

class CommentsDTO {
  final String id;
  final String uid;
  final String feedId;
  final String nickname;
  final String comment;
  final String createdAt;
  final String authorImageUrl;
  final String? parentId; // + 답글 기능을 위한 부모 댓글 ID
  final bool isDeleted; // + 소프트 딜리트 상태

  CommentsDTO({
    required this.id,
    required this.uid,
    required this.feedId,
    required this.nickname,
    required this.comment,
    required this.createdAt,
    required this.authorImageUrl,
    this.parentId,
    this.isDeleted = false,
  });

  factory CommentsDTO.fromJson(Map<String, dynamic> json) {
    return CommentsDTO(
      id: json['id'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      feedId: json['feedId'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      authorImageUrl: json['authorImageUrl'] as String? ?? '',
      parentId: json['parentId'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
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
      'authorImageUrl': authorImageUrl,
      'parentId': parentId,
      'isDeleted': isDeleted,
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
      authorImageUrl: authorImageUrl,
      isLiked: false, // 기본값
      likeCount: 0, // 기본값
      parentId: parentId,
      isDeleted: isDeleted,
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
      authorImageUrl: entity.authorImageUrl,
      parentId: entity.parentId,
      isDeleted: entity.isDeleted,
    );
  }
}
