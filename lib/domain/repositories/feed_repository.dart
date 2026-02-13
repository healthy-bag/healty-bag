import 'package:healthy_bag/domain/entities/feed_entity.dart';

abstract class FeedRepository {
  Future<FeedEntity?> fetchFeed(String feedId);

  // // 전체 피드 목록 가져오기 (필요시)
  Future<List<FeedEntity>> fetchFeeds();

  // 피드 등록 (최초 생성)
  Future<void> saveFeed(FeedEntity feed);

  // 피드 수정 (설명 수정 등)
  Future<void> updateFeed(FeedEntity feed);
}
