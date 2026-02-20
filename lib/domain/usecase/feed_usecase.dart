import 'dart:io';

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
    required String deletedAt,
    required String uid,
    required String authorId,
    required String authorimageUrl,
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
      createdAt: createdAt,
      deletedAt: deletedAt,
      authorId: authorId,
      authorimageUrl: authorimageUrl,
    );
    print("uid: $uid");
    await repository.saveFeed(newFeed, imageFile);
  }
}
