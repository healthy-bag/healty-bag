import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/block_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'block_usecase_di.g.dart';

@riverpod
BlockUsecase blockUsecase(Ref ref) =>
    BlockUsecase(ref.read(userRepositoryProvider));
