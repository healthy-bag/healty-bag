import 'dart:io';

import 'package:healthy_bag/data/DTO/feed_dto.dart';

abstract class FeedDataSource {
  // 이미지 업로드 후 URL 반환
  Future<String> uploadImage(File imageFile);
  // 피드 등록 (최초 생성)
  Future<void> saveFeed(FeedDTO feed);

  // 특정 피드 가져오기
  Future<FeedDTO?> fetchFeed(String feedId);

  // 전체 피드 목록 가져오기 (필요시)
  Future<List<FeedDTO>> fetchFeeds();

  // 피드 수정 (설명 수정 등)
  Future<void> updateFeed(FeedDTO feed);

  Stream<List<FeedDTO>> fetchMyFeeds(String userId);
}
