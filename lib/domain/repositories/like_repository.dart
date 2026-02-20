import 'package:healthy_bag/data/dto/likes_dto.dart';
import 'package:healthy_bag/domain/models/like_result.dart';

abstract class LikeRepository {
  Future<LikeResult> toggleLike(LikesDto likesDto);
  Future<LikeResult> isLiked(LikesDto likesDto);
}
