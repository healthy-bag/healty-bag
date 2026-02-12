import 'package:healthy_bag/data/DTO/user_dto.dart';

abstract class UserDataSource {
  Future<UserDTO?> fetchUserInfo(String uid);
  // Future<void> saveUserInfo(UserDTO user);
  // Future<void> updateUserInfo(String uid, Map<String, dynamic> data);
}
