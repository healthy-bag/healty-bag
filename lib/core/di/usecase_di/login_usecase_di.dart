import 'package:healthy_bag/core/di/repository_di/auth_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/google_login_usecase.dart';
import 'package:healthy_bag/domain/usecase/kakao_login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_usecase_di.g.dart';

@riverpod
GoogleLoginUsecase googleLoginUsecase(Ref ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final authRepository = ref.read(authRepositoryProvider);
  return GoogleLoginUsecase(
    authRepository: authRepository,
    userRepository: userRepository,
  );
}

@riverpod
KakaoLoginUsecase kakaoLoginUsecase(Ref ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final authRepository = ref.read(authRepositoryProvider);
  return KakaoLoginUsecase(
    authRepository: authRepository,
    userRepository: userRepository,
  );
}
