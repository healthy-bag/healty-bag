import 'package:healthy_bag/core/di/data_source_di/user_data_source_di.dart';
import 'package:healthy_bag/data/repositories_impl/user_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_di.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final userDataSource = ref.read(userDataSourceProvider);
  return UserRepositoryImpl(userDataSource: userDataSource);
}
