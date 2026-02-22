import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_block_notifier.g.dart';

@Riverpod(keepAlive: true)
class GlobalBlockViewModel extends _$GlobalBlockViewModel {
  @override
  Stream<List<String>> build() {
    return _setBlockedUsers(FirebaseAuth.instance.currentUser!.uid);
  }

  Stream<List<String>> _setBlockedUsers(String uid) async* {
    yield* ref.read(userRepositoryProvider).fetchBlockedUsers(uid);
  }
}
