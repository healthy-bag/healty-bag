import 'dart:io';

import 'package:healthy_bag/data/DTO/user_dto.dart';

abstract class UserDataSource {
  Future<UserDTO?> fetchUserInfo(String uid);
  Future<void> registerUser(UserDTO user);
  Future<bool> checkNickname(String nickname);
  Future<String> uploadProfileImage(File file);
  Future<void> addfeedCount(String uid);
}
