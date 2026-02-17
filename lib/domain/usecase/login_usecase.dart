import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/auth_result.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class LoginUsecase {
  LoginUsecase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<AuthResult> login(SocialType type) async {
    final result = await _authRepository.signIn(type);
    if (result == null) {
      return AuthFailure(message: "$type 로그인 실패");
    }
    final user = await _userRepository.getUserInfo(result.uid);
    if (user != null) {
      return AuthSuccess(user: user);
    } else {
      return NewUser(uid: result.uid);
    }
  }

  Future<UserEntity?> loginCheck() async {
    final String? uid = await _authRepository.getCurrentUid();
    if (uid == null) {
      return null;
    }
    final user = await _userRepository.getUserInfo(uid);
    if (user != null) {
      return user;
    }
    return null;
  }
}
