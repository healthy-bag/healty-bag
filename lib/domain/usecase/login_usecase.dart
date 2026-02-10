import 'package:healthy_bag/domain/entity/user_entity.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';

class LoginUsecase {
  LoginUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<UserEntity?> execute() async {
    final result = await _authRepository.signIn();
    if (result != null) {
      return result;
    }
    return null;
  }
}
