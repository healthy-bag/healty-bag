import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_tap_viewmodel.g.dart';

@riverpod
class MyTapViewmodel extends _$MyTapViewmodel {
  @override
  Stream<List<FeedEntity>> build() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return Stream.value([]);
    return ref.watch(feedRepositoryProvider).fetchMyFeeds(userId);
  }
  // Stream<List<String>> build() {
  //   final userId = FirebaseAuth.instance.currentUser?.uid;

  //   if (userId == null) return Stream.value([]);

  //   return ref.watch(feedRepositoryProvider).fetchMyFeedUrls(userId);
  // }

  Future<void> deleteFeed(String feedId) async {
    final user = ref.read(globalUserViewModelProvider);
    await ref.read(feedRepositoryProvider).deleteFeed(feedId);
    // 삭제 후 전체 개수를 다시 세어서 동기화
    await ref.read(userRepositoryProvider).addfeedCount(user!.uid);
    // ui 업데이트를 위해 유저 정보도 다시 불러오기
    ref.read(globalUserViewModelProvider.notifier).setUserById(user.uid);
  }
}
