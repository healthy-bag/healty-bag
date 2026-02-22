import 'dart:io';

import 'package:healthy_bag/data/dto/user_dto.dart';

abstract class UserDataSource {
  Future<UserDTO?> fetchUserInfo(String uid);
  Future<void> registerUser(UserDTO user);
  Future<bool> checkNickname(String nickname);
  Future<String> uploadProfileImage(File file);
  Future<void> addfeedCount(String uid);
  Stream<List<String>> fetchBlockedUsers(String uid);
  Future<void> blockUser(String uid, String blockedId);
  Future<void> unblockUser(String uid, String blockedId);
}
