import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';

class HomeViewModel extends Notifier<FeedEntity> {
  @override
  FeedEntity build() {
    // 초기 테스트 데이터 (추후 Repository 연동 가능)
    return FeedEntity(
      uid: 'user456',
      feedId: 'feed123',
      fileUrl: 'https://picsum.photos/800/800',
      content: '운동 많이 된다. 자기 전에 생각날거야',
      likeCount: 1000,
      commentCount: 30,
      thumbnailUrl: 'https://picsum.photos/200/200',
      tag: '#헬스',
      createdAt: DateTime.now().toIso8601String(),
      authorId: 'HealthyUser',
      authorimageUrl: 'https://picsum.photos/200/200',
      isLiked: false,
    );
  }

  void toggleLike() {
    final currentState = state;
    final newIsLiked = !currentState.isLiked;
    final newLikeCount = newIsLiked
        ? currentState.likeCount + 1
        : currentState.likeCount - 1;

    state = currentState.copyWith(isLiked: newIsLiked, likeCount: newLikeCount);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, FeedEntity>(() {
  return HomeViewModel();
});
