import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/core/di/usecase_di/follow_usecase_di.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/follow_result.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:healthy_bag/presentation/people/viewmodel/people_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_follow_notifier.g.dart';

@riverpod
class GlobalFollowNotifier extends _$GlobalFollowNotifier {
  @override
  Stream<List<String>> build() {
    final user = ref.watch(globalUserViewModelProvider);
    if (user == null) return Stream.value([]);
    return fetchFollowingUsers(user.uid);
  }

  Future<FollowResult> follow(UserEntity user, String followedId) async {
    final result = await ref
        .read(followUsecaseProvider)
        .follow(user, followedId);

    if (result is FollowSuccess) {
      ref.invalidate(peopleUserProvider(followedId));
      await ref
          .read(globalUserViewModelProvider.notifier)
          .setUserById(user.uid);
    }
    return result;
  }

  Future<FollowResult> unfollow(UserEntity user, String followedId) async {
    final result = await ref
        .read(followUsecaseProvider)
        .unfollow(user, followedId);

    if (result is FollowSuccess) {
      ref.invalidate(peopleUserProvider(followedId));
      await ref
          .read(globalUserViewModelProvider.notifier)
          .setUserById(user.uid);
    }
    return result;
  }

  Stream<List<String>> fetchFollowingUsers(String uid) async* {
    final result = await ref
        .read(userRepositoryProvider)
        .fetchFollowingUsers(uid);
    if (result is FetchFollowingUsersSuccess) {
      yield* result.data;
    }
  }
}
