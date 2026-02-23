import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';
import 'package:healthy_bag/presentation/my/viewmodel/my_tap_viewmodel.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_image.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_post_grid.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_stat.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(globalUserViewModelProvider);
    final feedUrlsAsync = ref.watch(myTapViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user!.nickname,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('차단'),
                  content: Text('해당 사용자를 차단하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text('취소'),
                    ),
                    TextButton(
                      onPressed: () {
                        // ref
                        //     .read(userRepositoryProvider)
                        //     .blockUser(FirebaseAuth.instance.currentUser!.uid);
                        // context.pop();
                      },
                      child: Text('차단'),
                    ),
                  ],
                ),
              );
            },
            child: Icon(Icons.report_sharp),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                ProfileImage(profileUrl: user.profileUrl),
                Padding(padding: const EdgeInsets.only(left: 16.0)),
                Spacer(),
                ProfileStat(label: '게시물', value: (user.feedCount).toString()),
                Spacer(),
                ProfileStat(label: '팔로워', value: user.followerCount.toString()),
                Spacer(),
                ProfileStat(
                  label: '팔로우',
                  value: user.followingCount.toString(),
                ),
                Spacer(),
              ],
            ),
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
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: feedUrlsAsync.when(
                data: (feed) {
                  return ProfilePostGrid(feeds: feed, isMyprofile: true);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text(error.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
