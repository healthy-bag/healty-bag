import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/dto/likes_dto.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeDataSource likeDataSource;
  LikeRepositoryImpl({required this.likeDataSource});

  @override
  Future<LikeResult> isLiked(LikesDto likesDto) async {
    try {
      final result = await likeDataSource.fetchMyLike(likesDto);
      return IsLikeSuccess(isLiked: result);
    } catch (e) {
      return LikeFailure(message: e.toString());
    }
  }

  @override
  Future<LikeResult> toggleLike(LikesDto likesDto) async {
    try {
      await likeDataSource.toggleLike(likesDto);
      return ToggleSuccess();
    } catch (e) {
      return LikeFailure(message: e.toString());
    }
  }
}
