import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/my/viewmodel/my_tap_viewmodel.dart';
import 'package:healthy_bag/presentation/my/widgets/detail_dialog.dart';

class ProfilePostGrid extends ConsumerWidget {
  const ProfilePostGrid({
    super.key,
    required this.feeds,
    required this.isMyprofile,
  });

  final List<FeedEntity> feeds;
  final bool isMyprofile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        final feed = feeds[index];
        return GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => DetailDialog(feed: feeds[index]),
          ),
          onLongPress: () {
            if (isMyprofile) {
              _showDeleteDialog(context, ref, feed.feedId);
            }
          },
          child: Image.network(
            feed.fileUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String feedId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게시물 삭제'),
        content: const Text('이 게시물을 정말로 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(myTapViewmodelProvider.notifier).deleteFeed(feedId);
              Navigator.pop(context);
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
