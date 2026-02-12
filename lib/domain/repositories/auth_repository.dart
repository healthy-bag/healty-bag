import 'package:healthy_bag/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn();
}
