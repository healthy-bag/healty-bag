import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/comment/comment_sheet.dart';
import 'package:healthy_bag/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: HealthyBagLogo(),
        // actions: [
        //   IconButton(onPressed: () {},
        //   icon: Icon(Icons.favorite_border, color: Colors.black,),),
        //   IconButton(onPressed: () {},
        //   icon: Icon(Icons.search, color: Colors.black,
        //   ))
        // ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/kiiiiit.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 8),
                      Text(
                        '이미지를 불러올 수 없습니다.\n($error)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "오늘 운동했으니까 엽떡",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSideIcon(Icons.favorite_border, '1만'),
                SizedBox(height: 20),
                _buildSideIcon(
                  Icons.chat_bubble_outline,
                  '100',
                  onTap: () => _showCommentSheet(context),
                ),
                SizedBox(height: 20),
                _buildSideIcon(Icons.bookmark_outline, '10'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        activeIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  // 사이드 아이콘 만드는 헬퍼 함수
  Widget _buildSideIcon(
    IconData iconData,
    String label, {
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap ?? () {},
          icon: Icon(iconData, color: Colors.white, size: 40),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: CommentSheet(),
      ),
    );
  }
}
