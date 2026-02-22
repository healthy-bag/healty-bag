import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';

class CommentDataSourceImpl implements CommentDataSource {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<CommentsDTO>> fetchComments(String feedId) {
    return _firestore
        .collection('comments')
        .where('feedId', isEqualTo: feedId)
        .snapshots()
        .map((snapshot) {
      final comments = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // 문서 ID를 데이터 내 id 필드로 보장
        return CommentsDTO.fromJson(data);
      }).toList();
      // 인 메모리 정렬 (인덱스 에러 방지용)
      comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return comments;
    });
  }

  @override
  Future<void> saveComment(CommentsDTO comment) async {
    final docRef = _firestore.collection('comments').doc();
    final isParent = comment.parentId == null || comment.parentId!.isEmpty;
    final newComment = comment.id.isEmpty
        ? CommentsDTO(
            id: docRef.id,
            uid: comment.uid,
            feedId: comment.feedId,
            nickname: comment.nickname,
            comment: comment.comment,
            createdAt: comment.createdAt,
            authorImageUrl: comment.authorImageUrl,
            parentId: comment.parentId,
          )
        : comment;

    await docRef.set(newComment.toJson());

    // 부모 댓글인 경우 피드의 댓글 카운트 증가
    if (isParent) {
      await _firestore.collection('feeds').doc(comment.feedId).update({
        'commentCount': FieldValue.increment(1),
      });
    }
  }

  @override
  // +답글 수정하기 기능
  Future<void> updateComment(String commentId, String content) async {
    await _firestore.collection('comments').doc(commentId).update({
      'comment': content,
    });
  }

  @override
  // +답글 삭제하기 기능 (조건부 삭제 및 부모댓글 정리 로직 포함)
  Future<void> deleteComment(String commentId) async {
    // 1. 현재 댓글 정보 가져오기 (parentId, feedId 확인용)
    final commentDoc =
        await _firestore.collection('comments').doc(commentId).get();
    if (!commentDoc.exists) return;

    final data = commentDoc.data()!;
    final String? parentId = data['parentId'] as String?;
    final String feedId = data['feedId'] as String;
    final bool isParent = parentId == null || parentId.isEmpty;

    // 2. 자식 답글이 있는지 확인
    final childrenQuery = await _firestore
        .collection('comments')
        .where('parentId', isEqualTo: commentId)
        .limit(1)
        .get();

    if (childrenQuery.docs.isNotEmpty) {
      // 자식이 있으면 소프트 딜리트
      await _firestore.collection('comments').doc(commentId).update({
        'isDeleted': true,
      });
    } else {
      // 자식이 없으면 하드 딜리트 (완전 삭제)
      await _firestore.collection('comments').doc(commentId).delete();

      // 3. 부모 댓글이 이미 '소프트 딜리트' 상태라면, 다른 자식이 남아있는지 확인 후 정리
      if (parentId != null && parentId.isNotEmpty) {
        await _cleanupParentIfOrphaned(parentId);
      }
    }

    // 부모 댓글이 삭제된 경우(소프트/하드 모두) 피드의 댓글 카운트 감소
    if (isParent) {
      await _firestore.collection('feeds').doc(feedId).update({
        'commentCount': FieldValue.increment(-1),
      });
    }
  }

  // 소프트 딜리트된 부모 댓글 중 자식이 더 이상 없는 경우를 찾아 완전 삭제
  Future<void> _cleanupParentIfOrphaned(String parentId) async {
    final parentDoc = await _firestore.collection('comments').doc(parentId).get();
    if (!parentDoc.exists) return;

    final parentData = parentDoc.data()!;
    final bool isParentDeleted = parentData['isDeleted'] as bool? ?? false;

    if (isParentDeleted) {
      // 다른 자식이 아직 남아있는지 확인
      final otherChildren = await _firestore
          .collection('comments')
          .where('parentId', isEqualTo: parentId)
          .limit(1)
          .get();

      if (otherChildren.docs.isEmpty) {
        // 더 이상 자식이 없으면 부모도 완전 삭제
        await _firestore.collection('comments').doc(parentId).delete();
        
        // (선택 사항) 조부모 댓글이 있다면 연쇄적으로 확인할 수도 있으나, 
        // 현재 앱의 계층 구조상 2단계이므로 여기까지만 처리해도 충분함.
      }
    }
  }
}
