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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const HealthyBagLogo(),
      ),
      // AsyncValue.when : 상태에 따른 화면 분기 처리
      // 데이터 로딩, 성공, 에러 상태 처리
      body: feedsAsync.when(
        data: (feeds) => PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: feeds.length,
          itemBuilder: (context, index) {
            final feed = feeds[index];
            return FeedItemWidget(
              feed: feed,
              onCommentTap: () => _showCommentSheet(context),
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

  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: CommentSheet(),
      ),
    );
  }
}
