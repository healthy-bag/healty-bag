import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/social_type.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn(SocialType type);
  Future<String?> getCurrentUid();
}
