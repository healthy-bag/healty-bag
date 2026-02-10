import 'package:healthy_bag/data/DTO/user_dto.dart';

abstract class UserDataSource {
  Future<UserDTO?> fetchUserInfo(String uid);
}
