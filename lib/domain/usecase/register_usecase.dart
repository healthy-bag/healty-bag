import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class RegisterUsecase {
  final UserRepository _userRepository;

  RegisterUsecase(this._userRepository);

  Future<bool> register({
    required String nickname,
    required String? imagePath,
    required String uid,
  }) async {
    final isNicknameAvailable = await _userRepository.checkNickname(nickname);
    if (!isNicknameAvailable) {
      return false;
    }

    String? profileUrl;
    if (imagePath != null) {
      profileUrl = await _userRepository.uploadProfileImage(File(imagePath));
    }

    final user = UserEntity(
      uid: uid,
      nickname: nickname,
      followerCount: 0,
      followingCount: 0,
      feedCount: 0,
      profileUrl: profileUrl,
    );

    await _userRepository.registerUser(user);
    return true;
  }
}
