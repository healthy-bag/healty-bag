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
          final comments = snapshot.docs
              .map((doc) => CommentsDTO.fromJson(doc.data()))
              .toList();
          // 인 메모리 정렬 (인덱스 에러 방지용)
          comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return comments;
        });
  }

  @override
  Future<void> saveComment(CommentsDTO comment) async {
    final docRef = _firestore.collection('comments').doc();
    final newComment = comment.id.isEmpty
        ? CommentsDTO(
            id: docRef.id,
            uid: comment.uid,
            feedId: comment.feedId,
            nickname: comment.nickname,
            comment: comment.comment,
            createdAt: comment.createdAt,
            authorImageUrl: comment.authorImageUrl,
            parentId: comment.parentId, // + 답글 부모 ID 추가
          )
        : comment;

    await docRef.set(newComment.toJson());
  }

  @override
  // +답글 수정하기 기능
  Future<void> updateComment(String commentId, String content) async {
    await _firestore.collection('comments').doc(commentId).update({
      'comment': content,
    });
  }

  @override
  // +답글 삭제하기 기능
  Future<void> deleteComment(String commentId) async {
    await _firestore.collection('comments').doc(commentId).delete();
  }
}
