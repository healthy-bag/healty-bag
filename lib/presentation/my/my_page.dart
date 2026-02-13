import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_image.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_post_grid.dart';
import 'package:healthy_bag/presentation/my/widgets/profile_stat.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HB_coding12',
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ProfileImage(),
                ),
                Spacer(),
                ProfileStat(label: '게시물', value: '2'),
                Spacer(),
                ProfileStat(label: '팔로워', value: '100'),
                Spacer(),
                ProfileStat(label: '팔로우', value: '80'),
                Spacer(),
              ],
            ),
            // Align(alignment: Alignment.centerRight, child: ProfileEditButton()),
            SizedBox(height: 32),
            Expanded(child: ProfilePostGrid()),
          ],
        ),
      ),
    );
  }
}
