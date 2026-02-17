import 'package:healthy_bag/data/DTO/comments_dto.dart';

abstract interface class CommentDataSource {
  Stream<List<CommentsDTO>> fetchComments(String feedId);
  Future<void> saveComment(CommentsDTO comment);
}
