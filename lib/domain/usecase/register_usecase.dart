import 'dart:io';

import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/save_image_result.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class RegisterUsecase {
  final UserRepository _userRepository;

  RegisterUsecase(this._userRepository);

  Future<bool> register({
    required String nickname,
    required String uid,
    required File? profileImage,
  }) async {
    final isNicknameAvailable = await _userRepository.checkNickname(nickname);
    if (!isNicknameAvailable) {
      return false;
    }

    final result = profileImage != null
        ? await _userRepository.uploadProfileImage(profileImage)
        : null;

    UserEntity user;
    if (result is SaveImageSuccess) {
      user = UserEntity(
        uid: uid,
        nickname: nickname,
        followerCount: 0,
        followingCount: 0,
        feedCount: 0,
        profileUrl: result.imageUrl,
      );
    } else if (result == null) {
      user = UserEntity(
        uid: uid,
        nickname: nickname,
        followerCount: 0,
        followingCount: 0,
        feedCount: 0,
        profileUrl: null,
      );
    } else {
      return false;
    }

    await _userRepository.registerUser(user);
    return true;
  }
}
