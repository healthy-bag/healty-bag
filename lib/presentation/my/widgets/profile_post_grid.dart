import 'package:flutter/material.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/my/widgets/detail_dialog.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({super.key, required this.feeds});

  final List<FeedEntity> feeds;

  @override
  Widget build(BuildContext context) {
    if (feeds.isEmpty) {
      return const Center(child: Text('아직 등록된 게시물이 없습니다.'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.95,
      ),
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => DetailDialog(feed: feeds[index]),
          ),
          child: Image.network(
            feeds[index].fileUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
