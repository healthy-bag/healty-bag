import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/follow_result.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class FollowUsecase {
  final UserRepository _userRepository;

  FollowUsecase(UserRepository userRepository)
    : _userRepository = userRepository;

  Future<FollowResult> follow(UserEntity user, String followedId) async {
    if (user.uid == followedId) {
      return FollowFailure(message: '자신을 팔로우 할 수 없습니다.');
    }
    await _userRepository.follow(user, followedId);
    return FollowSuccess();
  }

  Future<FollowResult> unfollow(UserEntity user, String followedId) async {
    if (user.uid == followedId) {
      return FollowFailure(message: '자신을 언팔로우 할 수 없습니다.');
    }
    await _userRepository.unfollow(user, followedId);
    return FollowSuccess();
  }
}
