import 'package:healthy_bag/data/dto/feed_dto.dart';
import 'package:healthy_bag/data/data_source/feed_data_source/feed_data_source.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource feedDataSource;

  FeedRepositoryImpl({required this.feedDataSource});

  @override
  Future<FeedEntity?> fetchFeed(String feedId) async {
    final feedDTO = await feedDataSource.fetchFeed(feedId);
    if (feedDTO == null) return null;
    return FeedEntity(
      uid: feedDTO.uid,
      feedId: feedDTO.feedId,
      fileUrl: feedDTO.fileUrl,
      content: feedDTO.content,
      likeCount: feedDTO.likeCount,
      commentCount: feedDTO.commentCount,
      thumbnailUrl: feedDTO.thumbnailUrl,
      tag: feedDTO.tag,
      createdAt: feedDTO.createdAt,
    );
  }

  @override
  Future<List<FeedEntity>> fetchFeeds() async {
    final feedDTOs = await feedDataSource.fetchFeeds();
    return feedDTOs
        .map(
          (feedDTO) => FeedEntity(
            uid: feedDTO.uid,
            feedId: feedDTO.feedId,
            fileUrl: feedDTO.fileUrl,
            content: feedDTO.content,
            likeCount: feedDTO.likeCount,
            commentCount: feedDTO.commentCount,
            thumbnailUrl: feedDTO.thumbnailUrl,
            tag: feedDTO.tag,
            createdAt: feedDTO.createdAt,
          ),
        )
        .toList();
  }

  @override
  Future<void> saveFeed(FeedEntity feed) async {
    final feedDTO = FeedDTO(
      uid: feed.uid,
      feedId: feed.feedId,
      fileUrl: feed.fileUrl,
      content: feed.content,
      likeCount: feed.likeCount,
      commentCount: feed.commentCount,
      thumbnailUrl: feed.thumbnailUrl,
      tag: feed.tag,
      createdAt: feed.createdAt,
    );
    await feedDataSource.saveFeed(feedDTO);
  }

  @override
  Future<void> updateFeed(FeedEntity feed) async {
    final feedDTO = FeedDTO(
      uid: feed.uid,
      feedId: feed.feedId,
      fileUrl: feed.fileUrl,
      content: feed.content,
      likeCount: feed.likeCount,
      commentCount: feed.commentCount,
      thumbnailUrl: feed.thumbnailUrl,
      tag: feed.tag,
      createdAt: feed.createdAt,
    );
    await feedDataSource.updateFeed(feedDTO);
  }
}
