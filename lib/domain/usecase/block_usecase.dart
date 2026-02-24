import 'package:healthy_bag/domain/repositories/user_repository.dart';

class BlockUsecase {
  final UserRepository _userRepository;

  BlockUsecase(UserRepository userRepository)
    : _userRepository = userRepository;

  Future<void> blockUser(String uid, String blockedId) async {
    if (uid == blockedId) return;

    return await _userRepository.blockUser(uid, blockedId);
  }

  Future<void> unblockUser(String uid, String blockedId) async {
    if (uid == blockedId) return;

    return await _userRepository.unblockUser(uid, blockedId);
  }
}
