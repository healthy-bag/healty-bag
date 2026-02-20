import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/comment/comment_sheet.dart';
import 'package:healthy_bag/presentation/home/home_view_model.dart';
import 'package:healthy_bag/presentation/home/widgets/feed_item.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

// ConsumerWidget을 사용하여 상태 관리
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedsAsync = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 변경
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const SizedBox(
          height: 40,
          child: HealthyBagLogo(),
        ),
      ),
      body: feedsAsync.when(
        data: (feeds) => ListView.builder(
          itemCount: feeds.length,
          itemBuilder: (context, index) {
            final feed = feeds[index];
            return FeedItemWidget(
              feed: feed,
              onCommentTap: () => _showCommentSheet(context, feed.feedId),
              onLikeTap: () => ref
                  .read(homeViewModelProvider.notifier)
                  .toggleLike(feed.feedId),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('에러 발생: $err')),
      ),
     
    );
  }

  void _showCommentSheet(BuildContext context, String feedId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 배경을 투명하게 하여 시트의 곡선이 잘 보이게 함
      builder: (context) => CommentSheet(feedId: feedId),
    );
  }
}
