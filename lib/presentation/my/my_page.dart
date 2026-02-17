import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_image.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_post_grid.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_stat.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(globalUserViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user!.nickname,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.favorite_outline, color: Colors.black),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search, color: Colors.black),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ProfileImage(profileUrl: user.profileUrl ?? null),
                Padding(padding: const EdgeInsets.only(left: 16.0)),
                Spacer(),
                ProfileStat(label: '게시물', value: user!.feedCount.toString()),
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
            SizedBox(height: 32),
            Expanded(child: ProfilePostGrid(feedCount: user.feedCount)),
          ],
        ),
      ),
    );
  }
}
