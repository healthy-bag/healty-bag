import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/dto/comments_dto.dart';

class CommentDataSourceImpl implements CommentDataSource {
  final FirebaseFirestore _firestore;

  CommentDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

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
    final String cleanFeedId = comment.feedId.trim();
    if (cleanFeedId.isEmpty) return; // feedId가 없으면 카운트 업데이트 불가능하므로 보호

    final docRef = _firestore.collection('comments').doc();
    final isParent = comment.parentId == null || comment.parentId!.trim().isEmpty;
    
    final newComment = comment.id.isEmpty
        ? CommentsDTO(
            id: docRef.id,
            uid: comment.uid,
            feedId: cleanFeedId, // 트림된 ID 사용
            nickname: comment.nickname,
            comment: comment.comment,
            createdAt: comment.createdAt,
            authorImageUrl: comment.authorImageUrl,
            parentId: comment.parentId?.trim(), // 트림 처리
          )
        : comment;

    // 1. 댓글 저장
    await docRef.set(newComment.toJson());

    // 2. 부모 댓글인 경우 피드의 댓글 카운트 증가
    if (isParent) {
      await _firestore.collection('feeds').doc(cleanFeedId).update({
        'commentCount': FieldValue.increment(1),
      }).catchError((e) {
        // 해당 피드 문서가 없거나 업데이트 실패 시 에러 로그 출력 (실제 운영 환경에선 모니터링 필요)
        print('피드 댓글 카운트 업데이트 실패: $e');
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
    final bool alreadyDeleted = data['isDeleted'] as bool? ?? false;
    if (alreadyDeleted) return; // 이미 삭제 처리된 경우 중복 처리 방지

    final String? parentId = (data['parentId'] as String?)?.trim();
    final String cleanFeedId = (data['feedId'] as String).trim();
    final bool isParent = parentId == null || parentId.isEmpty;

    // 2. 자식 답글이 있는지 확인 (삭제되지 않은 자식이 있는지 우선 확인)
    final childrenQuery = await _firestore
        .collection('comments')
        .where('parentId', isEqualTo: commentId)
        .limit(1)
        .get();

    if (childrenQuery.docs.isNotEmpty) {
      // 자식이 하나라도 있으면 소프트 딜리트
      await _firestore.collection('comments').doc(commentId).update({
        'isDeleted': true,
        'comment': '삭제된 댓글입니다.', // 데이터 보호를 위해 내용도 변경
      });
    } else {
      // 자식 댓글이 없으면 바로 삭제 (하드 딜리트: 바로 삭제)
      await _firestore.collection('comments').doc(commentId).delete();

      // 3. 부모 댓글과 자식 댓글이 있을 경우 (소프트 딜리트: 부모댓글만 삭제)
      if (parentId != null && parentId.isNotEmpty) {
        await _cleanupParentIfOrphaned(parentId);
      }
    }

    // 부모 댓글이 삭제된 경우(소프트/하드 모두) 피드의 댓글 카운트 감소
    if (isParent) {
      await _firestore.collection('feeds').doc(cleanFeedId).update({
        'commentCount': FieldValue.increment(-1),
      }).catchError((e) {
        print('피드 댓글 카운트 감소 실패: $e');
      });
    }
  }

  // 소프트 삭제 된 경우, 이후 자식 댓글도 삭제 되었다면 자식 댓글도 삭제 진행
  Future<void> _cleanupParentIfOrphaned(String parentId) async {
    final parentDoc = await _firestore.collection('comments').doc(parentId).get();
    if (!parentDoc.exists) return;

    final parentData = parentDoc.data()!;
    final bool isParentDeleted = parentData['isDeleted'] as bool? ?? false;

    if (isParentDeleted) {
      // 다른 자식댓글이 아직 남아있는지 확인
      final otherChildren = await _firestore
          .collection('comments')
          .where('parentId', isEqualTo: parentId)
          .limit(1)
          .get();

      if (otherChildren.docs.isEmpty) {
        // 더 이상 자식이 없으면 부모도 완전 삭제
        await _firestore.collection('comments').doc(parentId).delete();
      }
    }
  }
}
