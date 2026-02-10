import 'package:healthy_bag/data/data_source/user_data_source/remote/firebase_user_data_source_impl.dart';
import 'package:healthy_bag/data/data_source/user_data_source/user_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_source_di.g.dart';

@riverpod
UserDataSource userDataSource(Ref ref) {
  return FirebaseUserDataSourceImpl();
}
