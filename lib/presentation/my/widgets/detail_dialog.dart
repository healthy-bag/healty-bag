import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/di/usecase_di/like_usecase_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/notifier/global_like_notifier.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class DetailDialog extends ConsumerStatefulWidget {
  const DetailDialog({super.key, required this.feed});

  final FeedEntity feed;
  @override
  ConsumerState<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends ConsumerState<DetailDialog> {
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.feed.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(globalUserViewModelProvider);
    final myLikes = ref.watch(globalLikeProvider);
    final isLiked = myLikes.value?.contains(widget.feed.feedId) ?? false;

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.feed.fileUrl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                ItemButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  onTap: () async {
                    if (user == null) return;
                    if (isLiked) {
                      setState(() {
                        likeCount--;
                      });
                    } else {
                      setState(() {
                        likeCount++;
                      });
                    }
                    ref.read(likeUsecaseProvider).like(user, widget.feed);
                  },
                  content: likeCount.toString(),
                ),
                ItemButton(
                  icon: Icons.chat_bubble_outline,
                  onTap: () {},
                  content: widget.feed.commentCount.toString(),
                ),
              ],
            ),
            Text(widget.feed.content),
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
