import 'dart:io';
import 'package:healthy_bag/data/dto/feed_dto.dart';
import 'package:healthy_bag/data/data_source/feed_data_source/feed_data_source.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource feedDataSource;

  FeedRepositoryImpl({required this.feedDataSource});

  @override
  Future<void> saveFeed(FeedEntity feed, File imageFile) async {
    final imageUrl = await feedDataSource.uploadImage(imageFile);
    final feedDTO = FeedDTO(
      uid: feed.uid,
      feedId: feed.feedId,
      fileUrl: imageUrl,
      content: feed.content,
      likeCount: feed.likeCount,
      commentCount: feed.commentCount,
      thumbnailUrl: imageUrl,
      tag: feed.tag,
      createdAt: feed.createdAt,
      authorId: feed.authorId,
      authorimageUrl: feed.authorimageUrl,
    );
    await feedDataSource.saveFeed(feedDTO);
  }

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
      authorId: feedDTO.authorId,
      authorimageUrl: feedDTO.authorimageUrl,
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
            authorId: feedDTO.authorId,
            authorimageUrl: feedDTO.authorimageUrl,
          ),
        )
        .toList();
  }
  @override
  Stream<List<FeedEntity>> fetchFeedsStream() {
    return feedDataSource.fetchFeedsStream().map(
          (dtoList) => dtoList
              .map(
                (dto) => FeedEntity(
                  uid: dto.uid,
                  feedId: dto.feedId,
                  fileUrl: dto.fileUrl,
                  content: dto.content,
                  likeCount: dto.likeCount,
                  commentCount: dto.commentCount,
                  thumbnailUrl: dto.thumbnailUrl,
                  tag: dto.tag,
                  createdAt: dto.createdAt,
                  authorId: dto.authorId,
                  authorimageUrl: dto.authorimageUrl,
                ),
              )
              .toList(),
        );
  }

  // Stream<List<String>>: FeedEntity 리스트가 실시간으로 반환
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
      authorId: feed.authorId,
      authorimageUrl: feed.authorimageUrl,
    );
    await feedDataSource.updateFeed(feedDTO);
  }

  @override
  Stream<List<String>> fetchMyFeedUrls(String userId) {
    final feeds = feedDataSource.fetchMyFeeds(userId);
    return feeds.map((list) => list.map((dto) => dto.fileUrl).toList());
  }
}
