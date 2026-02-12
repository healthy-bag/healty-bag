import 'package:healthy_bag/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserInfo(String uid);
}
