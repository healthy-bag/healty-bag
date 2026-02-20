import 'package:healthy_bag/data/DTO/comments_dto.dart';

abstract interface class CommentDataSource {
  Stream<List<CommentsDTO>> fetchComments(String feedId);
  Future<void> saveComment(CommentsDTO comment);
  Future<void> updateComment(String commentId, String content); // + 수정 기능
  Future<void> deleteComment(String commentId); // + 삭제 기능
}
