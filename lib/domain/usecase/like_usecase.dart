import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';

class LikeUsecase {
  final LikeRepository _likeRepository;

  LikeUsecase(this._likeRepository);

  Future<LikeResult> like(UserEntity user, FeedEntity feed) async {
    final result = await _likeRepository.toggleLike(user, feed.feedId);
    if (result is LikeSuccess) {
      return LikeSuccess(data: result.data);
    } else {
      return LikeFailure(message: result.toString());
    }
  }
}
