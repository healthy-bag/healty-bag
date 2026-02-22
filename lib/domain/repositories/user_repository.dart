import 'dart:io';

import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/save_image_result.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserInfo(String uid);
  Future<void> registerUser(UserEntity user);
  Future<bool> checkNickname(String nickname);
  Future<SaveImageResult> uploadProfileImage(File file);
  Future<void> addfeedCount(String uid);
  Stream<List<String>> fetchBlockedUsers(String uid);
  Future<void> blockUser(String uid, String blockedId);
  Future<void> unblockUser(String uid, String blockedId);
}
