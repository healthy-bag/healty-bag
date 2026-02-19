import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_tap_viewmodel.g.dart';

@riverpod
class MyTapViewmodel extends _$MyTapViewmodel {
  @override
  Stream<List<String>> build() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return Stream.value([]);

    return ref.watch(feedRepositoryProvider).fetchMyFeedUrls(userId).map((
      urls,
    ) {
      return urls;
    });
  }
}
