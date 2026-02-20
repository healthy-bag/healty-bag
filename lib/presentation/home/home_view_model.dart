import 'package:healthy_bag/core/di/repository_di/comment_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart'; // 추가
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {

  @override
  Stream<List<FeedEntity>> build() {
    final feedRepository = ref.read(feedRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider); // 추가

    return feedRepository.fetchFeedsStream().asyncMap((feeds) async {
      // 각 피드에 대한 작성자 정보(닉네임, 프로필 이미지)를 실시간으로 가져와 병합
      final updatedFeeds = await Future.wait(feeds.map((feed) async {
        final userInfo = await userRepository.getUserInfo(feed.uid);
        if (userInfo != null) {
          return feed.copyWith(
            authorId: userInfo.nickname,
            authorimageUrl: userInfo.profileUrl ?? '',
          );
        }
        return feed;
      }));

      // 가져온 데이터를 생성일자(createdAt) 기준 내림차순 정렬
      updatedFeeds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return updatedFeeds;
    });
  }

  // 좋아요 버튼을 눌렀을 때 호출
  Future<void> toggleLike(String feedId) async {
    // 현재 상태 데이터 로드된 상태인지 확인
    final currentState = state;
    if (currentState is! AsyncData) return;

    // 현재 리스트에서 수정하려는 피드의 위치를 찾음
    final feeds = currentState.value!;
    final index = feeds.indexWhere((f) => f.feedId == feedId);
    if (index == -1) return;

    // 기존 피드 정보를 바탕으로 좋아요 상태와 개수를 변경한 새 피드 객체 만들기
    final feed = feeds[index];
    final newIsLiked = !feed.isLiked;
    final newLikeCount = newIsLiked ? feed.likeCount + 1 : feed.likeCount - 1;

    final updatedFeed = feed.copyWith(
      isLiked: newIsLiked,
      likeCount: newLikeCount,
    );

    // 낙관적 UI 업데이트
    final newList = [...feeds];
    newList[index] = updatedFeed;
    state = AsyncData(newList);

    try {
      final feedRepository = ref.read(feedRepositoryProvider);
      await feedRepository.updateFeed(updatedFeed);
    } catch (e) {
      // 에러 발생 시 원래 상태로 복구 (실제 앱에서는 더 정교한 처리가 필요할 수 있음)
      state = currentState;
    }
  }
}

@riverpod
Stream<List<CommentEntity>> feedComments(Ref ref, String feedId) {
  final commentRepository = ref.watch(commentRepositoryProvider);
  return commentRepository.getComments(feedId);
}
