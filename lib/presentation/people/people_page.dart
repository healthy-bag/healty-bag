import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_image.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_post_grid.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_stat.dart';
import 'package:healthy_bag/presentation/people/viewmodel/people_view_model.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class PeoplePage extends ConsumerWidget {
  final String uid;
  const PeoplePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 전달받은 uid를 사용하여 유저 정보와 피드 목록을 구독합니다.
    final userAsync = ref.watch(peopleUserProvider(uid));
    final feedsAsync = ref.watch(peopleFeedsProvider(uid));

    // 현재 로그인한 사용자 정보가져오기 (본인인지 확인용)
    final currentUser = ref.watch(globalUserViewModelProvider);
    final isMe = currentUser?.uid == uid;

    return Scaffold(
      // 유저 정보 상태에 따라 앱바 타이틀을 변경합니다.
      appBar: AppBar(
        centerTitle: true,
        title: userAsync.when(
          data: (user) => Text(
            user?.nickname ?? '알 수 없는 사용자',
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const Text('에러'),
        ),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('사용자를 찾을 수 없습니다.'));
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // 2. 마이페이지와 동일한 프로필 상단 레이아웃
                Row(
                  children: [
                    ProfileImage(profileUrl: user.profileUrl),
                    const Padding(padding: EdgeInsets.only(left: 16.0)),
                    const Spacer(),
                    ProfileStat(
                      label: '게시물',
                      value: feedsAsync.maybeWhen(
                        data: (feeds) => feeds.length.toString(),
                        orElse: () => user.feedCount.toString(),
                      ),
                    ),
                    const Spacer(),
                    ProfileStat(
                      label: '팔로워',
                      value: user.followerCount.toString(),
                    ),
                    const Spacer(),
                    ProfileStat(
                      label: '팔로우',
                      value: user.followingCount.toString(),
                    ),
                    const Spacer(),
                  ],
                ),

                // 3. 팔로우 버튼 (마이페이지의 빈 공간을 활용)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 36,
                    width: 220,
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(
                      child: Text(
                        '팔로우',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // 4. 피드 그리드 영역 (StreamProvider 구독)
                Expanded(
                  child: feedsAsync.when(
                    data: (feeds) =>
                        ProfilePostGrid(feeds: feeds, isMyprofile: isMe),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text('피드 로드 실패: $error')),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('유저 로드 실패: $error')),
      ),
    );
  }
}
