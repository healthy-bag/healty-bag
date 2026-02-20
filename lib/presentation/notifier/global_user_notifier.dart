import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class GlobalUserViewModel extends _$GlobalUserViewModel {
  @override
  UserEntity? build() {
    print(state);
    return null;
  }

  void setUser(UserEntity user) {
    state = user;
  }

  Future<void> setUserById(String uid) async {
    final user = await ref.read(userRepositoryProvider).getUserInfo(uid);
    state = user;
  }

  Future<void> updateFeedCount() async {
    state = state!.copyWith(feedCount: state!.feedCount + 1);
    await ref.read(userRepositoryProvider).addfeedCount(state!.uid);
  }
}
