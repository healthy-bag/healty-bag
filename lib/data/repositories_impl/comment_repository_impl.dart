import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/DTO/comments_dto.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentDataSource _commentDataSource;

  CommentRepositoryImpl(this._commentDataSource);

  @override
  Stream<List<CommentEntity>> getComments(String feedId) {
    return _commentDataSource
        .fetchComments(feedId)
        .map((dtos) => dtos.map((dto) => dto.toEntity()).toList());
  }

  @override
  Future<void> addComment(CommentEntity comment) async {
    final dto = CommentsDTO.fromEntity(comment);
    await _commentDataSource.saveComment(dto);
  }
}
