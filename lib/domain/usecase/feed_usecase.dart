import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';

class FeedUseCase {
  final FeedRepository repository;
  FeedUseCase({required this.repository});

  Future<void> execute({
    required String feedId,
    required File imageFile,
    required String content,
    required String tag,
    required int likeCount,
    required int commentCount,
    required String thumbnailUrl,
    required String createdAt,
    required String uid,
  }) async {
    final newFeed = FeedEntity(
      uid: uid,
      feedId: '',
      fileUrl: '',
      content: content,
      tag: tag,
      likeCount: likeCount,
      commentCount: commentCount,
      thumbnailUrl: '',
      createdAt: DateTime.now().toIso8601String(),
    );
    print("uid: $uid");
    await repository.saveFeed(newFeed, imageFile);
  }
}
