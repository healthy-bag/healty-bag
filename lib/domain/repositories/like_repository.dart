import 'package:healthy_bag/domain/models/like_result.dart';

abstract class LikeRepository {
  Future<LikeResult> toggleLike(String uid, String feedId);
  Future<LikeResult> isLiked(String uid, String feedId);
}
