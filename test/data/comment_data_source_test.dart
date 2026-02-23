import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/remote/comment_data_source_impl.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CommentDataSourceImpl dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = CommentDataSourceImpl(firestore: fakeFirestore);
  });

  group('CommentDataSource - saveComment 테스트', () {
    test('새로운 부모 댓글 저장 시 피드의 commentCount가 1 증가해야 한다', () async {
      // 1. 초기 피드 데이터 설정
      await fakeFirestore.collection('feeds').doc('feed1').set({
        'commentCount': 0,
      });

      final comment = CommentsDTO(
        id: '',
        uid: 'user1',
        feedId: 'feed1',
        nickname: 'tester',
        comment: '새 댓글',
        createdAt: DateTime.now().toIso8601String(),
        authorImageUrl: '',
      );

      // 2. 댓글 저장
      await dataSource.saveComment(comment);

      // 3. 검증
      final feedDoc = await fakeFirestore.collection('feeds').doc('feed1').get();
      expect(feedDoc.data()?['commentCount'], 1);

      final commentsSnapshot = await fakeFirestore.collection('comments').get();
      expect(commentsSnapshot.docs.length, 1);
    });

    test('답글(자식 댓글) 저장 시에는 피드의 commentCount가 증가하지 않아야 한다', () async {
      await fakeFirestore.collection('feeds').doc('feed1').set({
        'commentCount': 1,
      });

      final reply = CommentsDTO(
        id: '',
        uid: 'user2',
        feedId: 'feed1',
        nickname: 'replier',
        comment: '답글입니다',
        createdAt: DateTime.now().toIso8601String(),
        authorImageUrl: '',
        parentId: 'parent1',
      );

      await dataSource.saveComment(reply);

      final feedDoc = await fakeFirestore.collection('feeds').doc('feed1').get();
      expect(feedDoc.data()?['commentCount'], 1); // 변화 없음
    });
  });

  group('CommentDataSource - deleteComment 테스트', () {
    test('자식 댓글이 있는 부모 댓글 삭제 시 소프트 삭제(isDeleted=true)되어야 한다', () async {
      // 1. 부모 댓글과 자식 댓글 설정
      await fakeFirestore.collection('comments').doc('parent1').set({
        'feedId': 'feed1',
        'comment': '부모 댓글',
        'isDeleted': false,
        'parentId': null,
      });
      await fakeFirestore.collection('comments').doc('child1').set({
        'feedId': 'feed1',
        'comment': '자식 댓글',
        'parentId': 'parent1',
      });
      await fakeFirestore.collection('feeds').doc('feed1').set({'commentCount': 1});

      // 2. 부모 댓글 삭제 실행
      await dataSource.deleteComment('parent1');

      // 3. 검증: 소프트 삭제 확인
      final parentDoc = await fakeFirestore.collection('comments').doc('parent1').get();
      expect(parentDoc.exists, true);
      expect(parentDoc.data()?['isDeleted'], true);
      expect(parentDoc.data()?['comment'], '삭제된 댓글입니다.');

      // 피드 카운트는 감소해야 함
      final feedDoc = await fakeFirestore.collection('feeds').doc('feed1').get();
      expect(feedDoc.data()?['commentCount'], 0);
    });

    test('자식 댓글이 없는 부모 댓글 삭제 시 하드 삭제되어야 한다', () async {
      await fakeFirestore.collection('comments').doc('parent1').set({
        'feedId': 'feed1',
        'comment': '부모 댓글',
        'isDeleted': false,
      });
      await fakeFirestore.collection('feeds').doc('feed1').set({'commentCount': 1});

      await dataSource.deleteComment('parent1');

      final parentDoc = await fakeFirestore.collection('comments').doc('parent1').get();
      expect(parentDoc.exists, false);

      final feedDoc = await fakeFirestore.collection('feeds').doc('feed1').get();
      expect(feedDoc.data()?['commentCount'], 0);
    });

    test('소프트 삭제된 부모의 마지막 자식 댓글 삭제 시 부모도 함께 삭제되어야 한다 (오펀 정리)', () async {
      // 1. 소프트 삭제된 부모와 마지막 자식 설정
      await fakeFirestore.collection('comments').doc('parent1').set({
        'feedId': 'feed1',
        'comment': '삭제된 댓글입니다.',
        'isDeleted': true,
      });
      await fakeFirestore.collection('comments').doc('child1').set({
        'feedId': 'feed1',
        'comment': '마지막 자식',
        'parentId': 'parent1',
      });

      // 2. 자식 댓글 삭제 실행
      await dataSource.deleteComment('child1');

      // 3. 검증: 자식과 부모 모두 삭제됨 확인
      final childDoc = await fakeFirestore.collection('comments').doc('child1').get();
      expect(childDoc.exists, false);

      final parentDoc = await fakeFirestore.collection('comments').doc('parent1').get();
      expect(parentDoc.exists, false);
    });
  });
}
