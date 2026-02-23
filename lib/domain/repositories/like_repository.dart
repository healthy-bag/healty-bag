import 'package:healthy_bag/domain/entities/like_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';

abstract class LikeRepository {
  Future<LikeResult> toggleLike(LikeEntity likeEntity);
  Future<LikeResult> isLiked(LikeEntity likeEntity);
}
