import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/core/di/repository_di/comment_repository_di.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/repositories/comment_repository.dart';
import 'package:healthy_bag/presentation/comment/comment_view_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock 클래스 정의
class MockCommentRepository extends Mock implements CommentRepository {}
class MockAuthRepository extends Mock {
  Future<String?> getCurrentUid();
}
class MockUserRepository extends Mock {
  Future<dynamic> getUserInfo(String uid);
}

class FakeCommentEntity extends Fake implements CommentEntity {}

void main() {
  late MockCommentRepository mockCommentRepo;
  
  setUpAll(() {
    registerFallbackValue(FakeCommentEntity());
  });
  
  setUp(() {
    mockCommentRepo = MockCommentRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        commentRepositoryProvider.overrideWithValue(mockCommentRepo),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('CommentViewModel 상태 테스트', () {
    test('updateCommentText 호출 시 content 상태가 업데이트되어야 한다', () {
      final container = createContainer();
      final viewModel = container.read(commentViewModelProvider.notifier);

      viewModel.updateCommentText('테스트 댓글');

      expect(container.read(commentViewModelProvider).content, '테스트 댓글');
    });

    test('setReplyTarget 호출 시 parentComment가 설정되어야 한다', () {
      final container = createContainer();
      final viewModel = container.read(commentViewModelProvider.notifier);
      final target = CommentEntity(content: '부모', timeAgo: DateTime.now(), nickname: '부모님');

      viewModel.setReplyTarget(target);

      final state = container.read(commentViewModelProvider);
      expect(state.parentComment, target);
      expect(state.editingComment, isNull);
    });

    test('setEditTarget 호출 시 editingComment가 설정되고 content가 채워져야 한다', () {
      final container = createContainer();
      final viewModel = container.read(commentViewModelProvider.notifier);
      final target = CommentEntity(content: '수정할 내용', timeAgo: DateTime.now(), nickname: '작성자');

      viewModel.setEditTarget(target);

      final state = container.read(commentViewModelProvider);
      expect(state.editingComment, target);
      expect(state.content, '수정할 내용');
    });
  });

  group('CommentViewModel 제출 테스트', () {
    test('댓글 내용이 비어있으면 submitComment가 아무것도 하지 않아야 한다', () async {
      final container = createContainer();
      final viewModel = container.read(commentViewModelProvider.notifier);

      viewModel.updateCommentText('  '); // 공백 입력
      await viewModel.submitComment('feed1');

      verifyNever(() => mockCommentRepo.addComment(any()));
    });
  });
}
