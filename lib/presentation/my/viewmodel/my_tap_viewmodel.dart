import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
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
    await ref.read(feedRepositoryProvider).deleteFeed(feedId);
  }
}
