import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';


// dto를 entity로 변환하는 extension (mapper)
extension CommentsDTOExtension on CommentsDTO {
  CommentEntity toEntity (){
    return CommentEntity (
      nickname : this.nickname,
      content : this.comment,
      // DTO의 String 날짜를 DateTime으로 변환하는 로직
      timeAgo : DateTime.parse(this.createdAt),
      isLiked : false, // 기본값 설정
      likeCount : 0, // 기본값 설정
    );
  }
}

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
      id: json['id'] as String,
      uid: json['uid'] as String,
      feedId: json['feedId'] as String,
      nickname: json['nickname'] as String,
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String,
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
}
