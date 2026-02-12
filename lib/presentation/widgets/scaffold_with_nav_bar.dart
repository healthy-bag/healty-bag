import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/widgets/custom_bottom_navigation_bar.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 현재 탭의 화면
      body: navigationShell,
      // 작성하신 커스텀 바텀바 적용
      bottomNavigationBar: CustomBottomNavigationBar(
        activeIndex: navigationShell.currentIndex, // 현재 인덱스 전달
        onTap: (index) {
          // 탭 클릭 시 해당 브랜치로 이동
          navigationShell.goBranch(
            index,
            // 같은 탭을 다시 눌렀을 때의 동작 (선택사항: 첫 페이지로 이동)
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
