import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthy_bag/data/dto/feed_dto.dart';
import 'package:healthy_bag/data/data_source/feed_data_source/feed_data_source.dart';

class FeedDataSourceImpl implements FeedDataSource {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage(File imageFile) async {
    final storageRef = storage
        .ref()
        .child('feeds')
        .child('${DateTime.now().microsecondsSinceEpoch}');
    // 해당 위치에 이미지파일 업로드
    await storageRef.putFile(imageFile);
    // 업로드 후 참조에서 URL 가져오기
    return await storageRef.getDownloadURL();
  }

  @override
  Future<void> saveFeed(FeedDTO feed) async {
    final docRef = firestore
        .collection('feeds')
        .doc(feed.feedId.isEmpty ? null : feed.feedId);

    // 문서 ID와 필드 내부의 feedId를 일치시켜서 저장하는 것이 좋습니다.
    final newFeed = feed.feedId.isEmpty
        ? feed.copyWith(feedId: docRef.id)
        : feed;

    await docRef.set(newFeed.toJson());
  }

  @override
  Future<FeedDTO?> fetchFeed(String feedId) async {
    final doc = await firestore.collection('feeds').doc(feedId).get();
    if (doc.exists) {
      return FeedDTO.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<List<FeedDTO>> fetchFeeds() async {
    // feeds 컬렉션에서 가져오기
    // 필드명이 createdAt일 수도, createAt일 수도 있으므로 일단 가져온 후 코드에서 정렬하거나 처리
    final snapshot = await firestore.collection('feeds').get();

    return snapshot.docs.map((doc) => FeedDTO.fromJson(doc.data())).toList();
  }

  @override
  Stream<List<FeedDTO>> fetchFeedsStream() {
    return firestore
        .collection('feeds')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => FeedDTO.fromJson(doc.data())).toList(),
        );
  }

  @override
  Future<void> updateFeed(FeedDTO feed) async {
    // 이미 존재하는 문서의 특정 필드만 바꿀 때 update 사용
    await firestore.collection('feeds').doc(feed.feedId).update(feed.toJson());
  }

  // Stream<List<FeedDTO>> FeedDTO 객체들이 담긴 리스트를 실시간으로 반환
  @override
  Stream<List<FeedDTO>> fetchMyFeeds(String userId) async* {
    try {
      final snapshot = firestore
          .collection('feeds')
          // (필터링) 문서의 uid 필드가 입력받은 userId와 일치하는 데이터만 찾음
          .where('uid', isEqualTo: userId)
          // (정렬) createdAt 필드를 기준으로 내림차순 정렬
          .orderBy('createdAt', descending: true)
          // (실시간) 스트림으로 데이터 변경을 실시간으로 받음
          .snapshots();

      // yield* : 스트림을 반환하는 함수
      // 생성된 데이터 흐름(Stream)을 외부로 전달
      yield* snapshot.map(
        (snapshot) =>
            snapshot.docs.map((doc) => FeedDTO.fromJson(doc.data())).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
