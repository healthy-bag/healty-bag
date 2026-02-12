// dto를 entity로 변환하는 extension (mapper)
import 'package:healthy_bag/data/dto/comments_dto.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';

extension CommentsDTOExtension on CommentsDTO {
  CommentEntity toEntity() {
    return CommentEntity(
      nickname: nickname,
      content: comment,
      // DTO의 String 날짜를 DateTime으로 변환하는 로직
      timeAgo: DateTime.parse(createdAt),
      isLiked: false, // 기본값 설정
      likeCount: 0, // 기본값 설정
    );
  }
}
