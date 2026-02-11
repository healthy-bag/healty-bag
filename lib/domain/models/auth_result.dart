import 'package:healthy_bag/domain/entity/user_entity.dart';

sealed class AuthResult {}

class AuthSuccess extends AuthResult {
  final UserEntity user;
  AuthSuccess({required this.user});
}

class NewUser extends AuthResult {
  final String uid;
  NewUser({required this.uid});
}

class AuthFailure extends AuthResult {
  final String message;
  AuthFailure({required this.message});
}
