import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {

  // FutureOr<List<FeedEntity>>를 반환, 이 상태는 자동으로 'AsyncValue'로 관리
  @override
  FutureOr<List<FeedEntity>> build() async {
    // 의존성 주입된(ID) repository를 가져와 서버, 로컬 DB에서 데이터를 가져옴
    final feedRepository = ref.read(feedRepositoryProvider);
    final feeds = await feedRepository.fetchFeeds();
    
    // 가져온 데이터를 생성일자(createdAt) 기준 내림차순 정렬
    feeds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return feeds;
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
