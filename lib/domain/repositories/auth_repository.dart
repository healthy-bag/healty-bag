import 'package:healthy_bag/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn();
}
