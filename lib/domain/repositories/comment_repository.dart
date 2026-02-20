import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';

abstract interface class CommentRepository {
  Stream<List<CommentEntity>> getComments(String feedId);
  Future<void> addComment(CommentEntity comment);
  Future<void> updateComment(String commentId, String content); // + 수정 기능
  Future<void> deleteComment(String commentId); // + 삭제 기능
}
