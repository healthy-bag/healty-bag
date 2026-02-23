import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/repositories/comment_repository.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  // 댓글 데이터를 직접 가져오는 소스 (API 호출, 로컬 DB등)
  final CommentDataSource _commentDataSource;
  // + 댓글 작성자의 정보를 가져오기 위해 필요한 사용자 레포지토리
  final UserRepository _userRepository;

  CommentRepositoryImpl(this._commentDataSource, this._userRepository);

  @override
  Stream<List<CommentEntity>> getComments(String feedId) {
    return _commentDataSource.fetchComments(feedId).asyncMap((dtos) async {
      final entities = await Future.wait(dtos.map((dto) async {
        final entity = dto.toEntity();
        final userInfo = await _userRepository.getUserInfo(entity.uid);

        // 사용자 정보가 존재한다면, 댓글 엔티티에 닉네임과 프로필 사진을 덮어쓰우기
        if (userInfo != null) {
          return entity.copyWith(
            nickname: userInfo.nickname,
            authorImageUrl: userInfo.profileUrl ?? '',
          );
        }
        return entity;
      }));
      return entities;
    });
  }

  @override
  Future<void> addComment(CommentEntity comment) async {
    final dto = CommentsDTO.fromEntity(comment);
    await _commentDataSource.saveComment(dto);
  }

  @override
  Future<void> updateComment(String commentId, String content) async {
    await _commentDataSource.updateComment(commentId, content);
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _commentDataSource.deleteComment(commentId);
  }
}
