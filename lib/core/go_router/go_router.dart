import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/home/home_page.dart';
import 'package:healthy_bag/presentation/my/my_page.dart';
import 'package:healthy_bag/presentation/nickname/nickname_page.dart';
import 'package:healthy_bag/presentation/people/people_page.dart';
import 'package:healthy_bag/presentation/welcome/welcome_page.dart';
import 'package:healthy_bag/presentation/write/write_page.dart';
import 'package:healthy_bag/presentation/widgets/scaffold_with_nav_bar.dart';

final router = GoRouter(
  initialLocation: '/welcome',
  routes: [
    // 1. 로그인 페이지 (바텀바 없음)
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),

    // 2. 닉네임 설정 페이지 (바텀바 없음)
    GoRoute(
      path: '/nickname',
      name: 'nickname',
      builder: (context, state) => NicknamePage(),
    ),
    GoRoute(
      path: '/people/:uid',
      name: 'people',
      builder: (context, state) {
        final uid = state.pathParameters['uid'] as String;
        return PeoplePage(uid: uid);
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // 여기에 커스텀 바텀바가 포함된 레이아웃 위젯을 넣습니다.
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my',
              name: 'my',
              builder: (context, state) => const MyPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/edit',
              name: 'edit',
              builder: (context, state) => const WritePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
