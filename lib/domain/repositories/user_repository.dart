import 'package:healthy_bag/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserInfo(String uid);
}
