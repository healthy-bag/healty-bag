import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';
import 'package:healthy_bag/data/repositories_impl/comment_repository_impl.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentDataSource extends Mock implements CommentDataSource {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockCommentDataSource mockDataSource;
  late MockUserRepository mockUserRepository;
  late CommentRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCommentDataSource();
    mockUserRepository = MockUserRepository();
    repository = CommentRepositoryImpl(mockDataSource, mockUserRepository);
  });

  group('CommentRepository - getComments 테스트', () {
    test('DataSource에서 받은 DTO 리스트가 Entity 리스트로 변환되고 사용자 정보가 병합되어야 한다', () async {
      final now = DateTime.now();
      final dtos = [
        CommentsDTO(
          id: '1',
          uid: 'u1',
          feedId: 'f1',
          nickname: 'old_nick',
          comment: 'c1',
          createdAt: now.toIso8601String(),
          authorImageUrl: 'old_url',
        ),
      ];

      final userEntity = UserEntity(
        uid: 'u1',
        nickname: 'new_nick',
        profileUrl: 'new_url',
        followerCount: 0,
        followingCount: 0,
        feedCount: 0,
      );

      when(() => mockDataSource.fetchComments('f1'))
          .thenAnswer((_) => Stream.value(dtos));
      when(() => mockUserRepository.getUserInfo('u1'))
          .thenAnswer((_) async => userEntity);

      final stream = repository.getComments('f1');

      final result = await stream.first;

      expect(result.first.commentId, '1');
      expect(result.first.nickname, 'new_nick');
      expect(result.first.authorImageUrl, 'new_url');
    });

    test('사용자 정보가 없는 경우에도 기본 정보로 Entity가 생성되어야 한다', () async {
      final now = DateTime.now();
      final dtos = [
        CommentsDTO(
          id: '1',
          uid: 'u1',
          feedId: 'f1',
          nickname: 'old_nick',
          comment: 'c1',
          createdAt: now.toIso8601String(),
          authorImageUrl: 'old_url',
        ),
      ];

      when(() => mockDataSource.fetchComments('f1'))
          .thenAnswer((_) => Stream.value(dtos));
      when(() => mockUserRepository.getUserInfo('u1'))
          .thenAnswer((_) async => null);

      final stream = repository.getComments('f1');
      final result = await stream.first;

      expect(result.first.nickname, 'old_nick');
      expect(result.first.authorImageUrl, 'old_url');
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
