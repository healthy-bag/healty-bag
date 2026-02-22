import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/my/viewmodel/my_tap_viewmodel.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class DetailDialog extends ConsumerWidget {
  const DetailDialog({super.key, required this.feed});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(globalUserViewModelProvider);
    final bool isMe = currentUser?.uid == feed.uid;
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(feed.fileUrl),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chat_bubble_outline),
                ),
                if (isMe) ...[
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      // 1. 바텀시트 띄우고 결과 대기
                      final String? action = await showModalBottomSheet<String>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('수정하기'),
                                  onTap: () => Navigator.pop(context, 'edit'),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    '삭제하기',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () => Navigator.pop(context, 'delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      );

                      if (action == 'delete' && context.mounted) {
                        // 2. 삭제 확인 다이얼로그 띄우고 결과 대기
                        final bool? confirmed = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('게시물 삭제'),
                              content: const Text('이 게시물을 정말로 삭제하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(dialogContext, false),
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(dialogContext, true),
                                  child: const Text(
                                    '삭제',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        // 3. 최종 삭제 실행 및 상세창 닫기
                        if (confirmed == true && context.mounted) {
                          ref
                              .read(myTapViewmodelProvider.notifier)
                              .deleteFeed(feed.feedId);

                          // 현재 DetailDialog를 닫음
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ],
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
