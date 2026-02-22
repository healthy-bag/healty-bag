import 'package:healthy_bag/core/di/repository_di/auth_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/comment_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/like_repository_di.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart'; 
import 'package:healthy_bag/data/dto/likes_dto.dart';
import 'package:healthy_bag/domain/entities/comment/comment_entity.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/like_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {

  @override
  Stream<List<FeedEntity>> build() {
    final feedRepository = ref.read(feedRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final likeRepository = ref.read(likeRepositoryProvider);

    return feedRepository.fetchFeedsStream().asyncMap((feeds) async {
      final myUid = await authRepository.getCurrentUid();

      // 각 피드에 대한 작성자 정보(닉네임, 프로필 이미지) 및 좋아요 여부를 실시간으로 가져와 병합
      final updatedFeeds = await Future.wait(feeds.map((feed) async {
        final userInfoFuture = userRepository.getUserInfo(feed.uid);

        Future<bool> isLikedFuture = Future.value(false);
        if (myUid != null) {
          isLikedFuture = likeRepository
              .isLiked(LikesDto(
                id: '',
                uid: myUid,
                nickname: '',
                feedId: feed.feedId,
              ))
              .then((result) => result is IsLikeSuccess ? result.isLiked : false);
        }

        final results = await Future.wait([userInfoFuture, isLikedFuture]);
        final userInfo = results[0] as UserEntity?;
        final isLiked = results[1] as bool;

        var updatedFeed = feed.copyWith(isLiked: isLiked);
        if (userInfo != null) {
          updatedFeed = updatedFeed.copyWith(
            authorId: userInfo.nickname,
            authorimageUrl: userInfo.profileUrl ?? '',
          );
        }
        return updatedFeed;
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

    final feed = feeds[index];
    final authRepository = ref.read(authRepositoryProvider);
    final likeRepository = ref.read(likeRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    final myUid = await authRepository.getCurrentUid();
    if (myUid == null) return;

    // 내 정보 조회를 통해 닉네임 확보 (좋아요 기록용)
    final myInfo = await userRepository.getUserInfo(myUid);
    final myNickname = myInfo?.nickname ?? '익명';

    // 기존 피드 정보를 바탕으로 좋아요 상태와 개수를 변경한 새 피드 객체 만들기
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
      final likesDto = LikesDto(
        id: '${myUid}_$feedId', // 고유 ID 생성 규칙
        uid: myUid,
        nickname: myNickname,
        feedId: feedId,
      );
      // LikeRepository를 통한 좋아요 토글 (트랜잭션 처리됨)
      await likeRepository.toggleLike(likesDto);
    } catch (e) {
      // 에러 발생 시 원래 상태로 복구
      state = currentState;
    }
  }
}

@riverpod
Stream<List<CommentEntity>> feedComments(Ref ref, String feedId) {
  final commentRepository = ref.watch(commentRepositoryProvider);
  return commentRepository.getComments(feedId);
}
