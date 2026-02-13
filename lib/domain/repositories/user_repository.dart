import 'dart:io';

import 'package:healthy_bag/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserInfo(String uid);
  Future<void> registerUser(UserEntity user);
  Future<bool> checkNickname(String nickname);
  Future<String> uploadProfileImage(File file);
}
