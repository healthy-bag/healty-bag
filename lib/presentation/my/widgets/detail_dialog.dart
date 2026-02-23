import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/di/usecase_di/like_usecase_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class DetailDialog extends ConsumerWidget {
  const DetailDialog({super.key, required this.feed});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(feed.fileUrl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                ItemButton(
                  icon: Icons.favorite_border,
                  onTap: () {
                    final user = ref.read(globalUserViewModelProvider);
                    if (user == null) return;
                    ref.read(likeUsecaseProvider).like(user.uid, feed);
                  },
                  content: feed.likeCount.toString(),
                ),
                ItemButton(
                  icon: Icons.chat_bubble_outline,
                  onTap: () {},
                  content: feed.commentCount.toString(),
                ),
              ],
            ),
            Text(feed.content),
          ],
        ),
      ),
      icon: GestureDetector(
        onTap: () {
          if (context.mounted) context.pop();
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Icon(CupertinoIcons.xmark, color: Colors.black),
        ),
      ),
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.content,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onTap, icon: Icon(icon)),
        Text(content),
      ],
    );
  }
}
