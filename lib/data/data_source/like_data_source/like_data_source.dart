import 'package:healthy_bag/data/dto/likes_dto.dart';

abstract class LikeDataSource {
  Future<void> toggleLike(LikesDto likesDto);
  Future<bool> fetchMyLike(LikesDto likesDto);
  Stream<List<String>> fetchMyLikes(String uid);
}
