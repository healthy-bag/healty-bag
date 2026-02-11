import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/remote/google_auth_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_source_di.g.dart';

@riverpod
AuthDataSource authDataSource(Ref ref) {
  return GoogleAuthDataSource();
}
