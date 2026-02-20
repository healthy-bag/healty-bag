import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/save_image_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_image_usecase_di.g.dart';

@riverpod
SaveImageUsecase saveImageUsecase(Ref ref) {
  return SaveImageUsecase(userRepository: ref.read(userRepositoryProvider));
}
