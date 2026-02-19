import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';

abstract interface class CommentRepository {
  Stream<List<CommentEntity>> getComments(String feedId);
  Future<void> addComment(CommentEntity comment);
}
