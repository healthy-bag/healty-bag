import 'package:healthy_bag/domain/repositories/user_repository.dart';

class BlockUsecase {
  final UserRepository _userRepository;

  BlockUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<void> execute(String uid, String blockedId, bool isBlocked) async {
    if (uid == blockedId) return;

    if (isBlocked) {
      return await _userRepository.unblockUser(uid, blockedId);
    } else {
      return await _userRepository.blockUser(uid, blockedId);
    }
  }
}
