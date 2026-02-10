import 'package:healthy_bag/core/di/data_source_di/auth_data_source_di.dart';
import 'package:healthy_bag/core/di/data_source_di/user_data_source_di.dart';
import 'package:healthy_bag/data/repositories_impl/auth_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_di.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    authDataSource: ref.watch(authDataSourceProvider),
    userDataSource: ref.watch(userDataSourceProvider),
  );
}
