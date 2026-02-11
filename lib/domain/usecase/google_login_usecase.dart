import 'package:healthy_bag/domain/models/auth_result.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class GoogleLoginUsecase {
  GoogleLoginUsecase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<AuthResult> execute() async {
    final result = await _authRepository.signIn();
    if (result == null) {
      return AuthFailure(message: "로그인을 실패했습니다");
    }

    final user = await _userRepository.getUserInfo(result.uid);
    if (user != null) {
      return AuthSuccess(user: user);
    } else {
      return NewUser(uid: result.uid);
    }
  }
}
