import 'package:flutter/material.dart';
import 'package:healthy_bag/domain/entities/feed/feed_entity.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/presentation/comment/comment_sheet.dart';
import 'package:healthy_bag/presentation/home/widgets/feed_item.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class HomePage extends StatelessWidget {
  final UserEntity user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // 임시 테스트용 데이터 (TODO: 나중에 Entity로 바꾸기)
    // final testFeed = FeedEntity(
    //   id: 'jin123',
    //   authorId: 'user456',
    //   authorimageUrl: 'https://picsum.photos/200/300',
    //   imageUrl: 'https://picsum.photos/800/300',
    //   content: '운동 많이 된다. 자기 전에 생각날거야',
    //   likes: 1000,
    //   comments: 30,
    //   updatedAt: DateTime.now(),
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: HealthyBagLogo(),
      ),
      // body: Builder(
      //   builder: (innerContext) => FeedItemWidget(
      //     // feed: testFeed,
      //     onCommentTap: () => _showCommentSheet(innerContext),
      //   ),
      // ),
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
