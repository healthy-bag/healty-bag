import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/comment/comment_sheet.dart';
import 'package:healthy_bag/presentation/home/home_view_model.dart';
import 'package:healthy_bag/presentation/home/widgets/feed_item.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(homeViewModelProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const HealthyBagLogo(),
      ),
      body: Builder(
        builder: (innerContext) => FeedItemWidget(
          feed: feed,
          onCommentTap: () => _showCommentSheet(innerContext),
          onLikeTap: () =>
              ref.read(homeViewModelProvider.notifier).toggleLike(),
        ),
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
