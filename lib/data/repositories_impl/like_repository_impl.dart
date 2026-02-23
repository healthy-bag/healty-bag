import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/dto/likes_dto.dart';
import 'package:healthy_bag/domain/entities/like_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeDataSource likeDataSource;
  LikeRepositoryImpl({required this.likeDataSource});

  @override
  Future<LikeResult> isLiked(LikeEntity likeEntity) async {
    try {
      final likeDTO = LikesDto(
        id: likeEntity.id,
        uid: likeEntity.uid,
        nickname: likeEntity.nickname,
        feedId: likeEntity.feedId,
      );

      final result = await likeDataSource.fetchMyLike(likeDTO);
      return LikeSuccess(data: result);
    } catch (e) {
      return LikeFailure(message: e.toString());
    }
  }

  @override
  Future<LikeResult> toggleLike(LikeEntity likeEntity) async {
    try {
      final likeDTO = LikesDto(
        id: likeEntity.id,
        uid: likeEntity.uid,
        nickname: likeEntity.nickname,
        feedId: likeEntity.feedId,
      );

      await likeDataSource.toggleLike(likeDTO);
      return LikeSuccess(data: null);
    } catch (e) {
      return LikeFailure(message: e.toString());
    }
  }
}
