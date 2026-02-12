import 'package:healthy_bag/data/data_source/auth_data_source/firebase_auth_remote/auth_remote_data_source.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/firebase_auth_remote/remote/firebase_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source_di.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return FirebaseRemoteDataSource();
}
