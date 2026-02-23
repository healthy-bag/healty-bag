import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';

abstract class LikeRepository {
  Future<LikeResult> toggleLike(UserEntity user, String feedId);
  Future<LikeResult> isLiked(UserEntity user, String feedId);
  Stream<List<String>> fetchMyLikes(String uid);
}
