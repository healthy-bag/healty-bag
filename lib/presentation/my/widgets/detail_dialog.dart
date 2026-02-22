import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/my/viewmodel/my_tap_viewmodel.dart';

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
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chat_bubble_outline),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showOptionsBottomSheet(context, ref);
                  },
                  child: Icon(Icons.more_vert),
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

  void _showOptionsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('수정하기'),
                onTap: () {
                  context.pop(); // 바텀시트 닫기
                  // TODO: 수정 기능 연결
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('삭제하기', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // 1. 일단 바텀시트 닫기

                  // 2. 삭제 재확인 다이얼로그 띄우기
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('게시물 삭제'),
                        content: const Text('이 게시물을 정말로 삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext); // 확인창만 닫기 (취소)
                            },
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              // 진짜 삭제 진행
                              ref
                                  .read(myTapViewmodelProvider.notifier)
                                  .deleteFeed(feed.feedId);

                              // 3. 다이얼로그 완전히 닫기 (마이페이지로 돌아감)
                              // 현재 열려있는 삭제 확인창(dialogContext) 닫기
                              Navigator.pop(dialogContext);

                              // 원래 떠 있던 사진 상세창(DetailDialog의 context) 닫기
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              '삭제',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
