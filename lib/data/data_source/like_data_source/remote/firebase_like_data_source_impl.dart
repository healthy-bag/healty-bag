import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/dto/likes_dto.dart';

class FirebaseLikeDataSourceImpl implements LikeDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> fetchMyLike(LikesDto likesDto) async {
    try {
      final String likeId = '${likesDto.uid}_${likesDto.feedId}';
      final doc = await _firestore.collection('likes').doc(likeId).get();
      return doc.exists;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> toggleLike(LikesDto likesDto) async {
    try {
      // 좋아요 추가/삭제 로직
      final String likeId = '${likesDto.uid}_${likesDto.feedId}';
      final likeRef = _firestore.collection('likes').doc(likeId);
      final feedRef = _firestore.collection('feeds').doc(likesDto.feedId);

      await _firestore.runTransaction((transaction) async {
        final likeSnapshot = await transaction.get(likeRef);
        final feedSnapshot = await transaction.get(feedRef);

        if (likeSnapshot.exists) {
          // 이미 좋아요를 누른 경우: 좋아요 삭제 및 카운트 감소
          transaction.delete(likeRef);
          if (feedSnapshot.exists) {
            transaction.update(feedRef, {
              'likeCount': FieldValue.increment(-1),
            });
          }
        } else {
          // 좋아요를 누르지 않은 경우: 좋아요 추가 및 카운트 증가
          transaction.set(likeRef, likesDto.toJson());
          if (feedSnapshot.exists) {
            transaction.update(feedRef, {
              'likeCount': FieldValue.increment(1),
            });
          }
        }
      });
    } on FirebaseException {
      rethrow;
    }
  }
}
