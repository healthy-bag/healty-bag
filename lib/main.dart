import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bag/core/go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/firebase_options.dart';
import 'package:healthy_bag/core/theme/app_theme.dart';
import 'package:healthy_bag/presentation/welcome/welcome_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '1a4606b9ff1a6ec5aca367009f36896a');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Healthy Bag',
      theme: AppTheme.lightTheme,
      // home: WelcomePage(),
      // home: WritePage(),
      // home: MyPage(),
      // home: HomePage(),
      home: WelcomePage(),
    );
  }
}
