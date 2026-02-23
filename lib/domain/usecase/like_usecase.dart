import 'package:healthy_bag/domain/entities/like_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';

class LikeUsecase {
  final LikeRepository _likeRepository;

  LikeUsecase(this._likeRepository);

  Future<LikeResult> like(LikeEntity likeEntity) async {
    final result = await _likeRepository.toggleLike(likeEntity);
    if (result is LikeSuccess) {
      return LikeSuccess(data: result.data);
    } else {
      return LikeFailure(message: result.toString());
    }
  }
}
