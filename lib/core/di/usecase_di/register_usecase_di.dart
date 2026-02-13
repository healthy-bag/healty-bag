import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/register_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_usecase_di.g.dart';

@riverpod
RegisterUsecase registerUsecase(Ref ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return RegisterUsecase(userRepository);
}
