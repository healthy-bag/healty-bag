import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';

final peopleUserProvider = FutureProvider.family<UserEntity?, String>((
  ref,
  uid,
) {
  return ref.watch(userRepositoryProvider).getUserInfo(uid);
});

final peopleFeedsProvider = StreamProvider.family<List<FeedEntity>, String>((
  ref,
  uid,
) {
  return ref.watch(feedRepositoryProvider).fetchMyFeeds(uid);
});
