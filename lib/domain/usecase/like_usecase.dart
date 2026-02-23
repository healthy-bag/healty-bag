import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/entities/like_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';

class LikeUsecase {
  final LikeRepository _likeRepository;
  final FeedRepository _feedRepository;

  LikeUsecase(this._likeRepository, this._feedRepository);

  Future<LikeResult> like(String uid, FeedEntity feed) async {
    final result = await _likeRepository.toggleLike(uid, feed.feedId);
    if (result is LikeSuccess) {
      _feedRepository.updateFeed(feed);
      return LikeSuccess(data: result.data);
    } else {
      return LikeFailure(message: result.toString());
    }
  }
}
