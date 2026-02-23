import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';
import 'package:healthy_bag/data/repositories_impl/comment_repository_impl.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentDataSource extends Mock implements CommentDataSource {}

void main() {
  late MockCommentDataSource mockDataSource;
  late CommentRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCommentDataSource();
    repository = CommentRepositoryImpl(mockDataSource);
  });

  group('CommentRepository - getComments 테스트', () {
    test('DataSource에서 받은 DTO 리스트가 Entity 리스트로 변환되어 전달되어야 한다', () {
      final dtos = [
        CommentsDTO(
          id: '1',
          uid: 'u1',
          feedId: 'f1',
          nickname: 'n1',
          comment: 'c1',
          createdAt: DateTime.now().toIso8601String(),
          authorImageUrl: '',
        ),
      ];

      when(() => mockDataSource.fetchComments('f1'))
          .thenAnswer((_) => Stream.value(dtos));

      final stream = repository.getComments('f1');

      expect(
        stream,
        emits(predicate<List<CommentEntity>>((list) => list.first.commentId == '1')),
      );
    });
  });

  group('CommentRepository - addComment 테스트', () {
    test('Entity가 DTO로 변환되어 DataSource의 saveComment를 호출해야 한다', () async {
      final entity = CommentEntity(
        commentId: '1',
        feedId: 'f1',
        uid: 'u1',
        content: 'hello',
        timeAgo: DateTime.now(),
        nickname: 'nick',
      );

      registerFallbackValue(CommentsDTO(
        id: '',
        uid: '',
        feedId: '',
        nickname: '',
        comment: '',
        createdAt: '',
        authorImageUrl: '',
      ));

      when(() => mockDataSource.saveComment(any())).thenAnswer((_) async => {});

      await repository.addComment(entity);

      verify(() => mockDataSource.saveComment(any())).called(1);
    });
  });
}
