import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bag/core/di/repository_di/like_repository_di.dart';
import 'package:healthy_bag/core/di/usecase_di/like_usecase_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_like_notifier.g.dart';

@Riverpod(keepAlive: true)
class GlobalLikeNotifier extends _$GlobalLikeNotifier {
  final Set<String> _processingFeeds = {};

  @override
  Stream<List<String>> build() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Stream.value([]);
    }
    return _fetchMyLikes(FirebaseAuth.instance.currentUser!.uid);
  }

  Stream<List<String>> _fetchMyLikes(String uid) async* {
    yield* ref.read(likeRepositoryProvider).fetchMyLikes(uid);
  }

  Future<void> toggleLike(UserEntity user, FeedEntity feed) async {
    final feedId = feed.feedId;

    if (_processingFeeds.contains(feedId)) return;

    _processingFeeds.add(feedId);

    try {
      await ref.read(likeUsecaseProvider).like(user, feed);
    } catch (e) {
      debugPrint('Error toggling like: $e');
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));
      _processingFeeds.remove(feedId);
    }
  }
}
