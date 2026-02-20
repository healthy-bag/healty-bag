import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/dto/likes_dto.dart';

class FirebaseLikeDataSourceImpl implements LikeDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> fetchMyLike(LikesDto likesDto) async {
    try {
      final snapshot = await _firestore
          .collection('likes')
          .where('uid', isEqualTo: likesDto.uid)
          .where('feedId', isEqualTo: likesDto.feedId)
          .get();
      return snapshot.docs.isNotEmpty;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> toggleLike(LikesDto likesDto) async {
    try {
      final snapshot = await _firestore
          .collection('likes')
          .doc(likesDto.id)
          .get();
      if (snapshot.exists) {
        await _firestore.collection('likes').doc(snapshot.id).delete();
      } else {
        await _firestore.collection('likes').add(likesDto.toJson());
      }
    } on FirebaseException {
      rethrow;
    }
  }
}
