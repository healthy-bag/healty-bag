import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bag/core/di/repository_di/like_repository_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_like_notifier.g.dart';

@Riverpod(keepAlive: true)
class GlobalLikeNotifier extends _$GlobalLikeNotifier {
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
}
