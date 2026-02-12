import 'package:healthy_bag/core/di/repository_di/auth_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_usecase_di.g.dart';

@riverpod
LoginUsecase loginUsecase(Ref ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final authRepository = ref.read(authRepositoryProvider);
  return LoginUsecase(
    authRepository: authRepository,
    userRepository: userRepository,
  );
}
