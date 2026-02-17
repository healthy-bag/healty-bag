import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bag/core/config/env.dart';
import 'package:healthy_bag/core/go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/firebase_options.dart';
import 'package:healthy_bag/core/theme/app_theme.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: Env.kakaoAppKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFCM();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navigatorKey,
      routerConfig: router,
      title: 'Healthy Bag',
      theme: AppTheme.lightTheme,
    );
  }
}

// FCM 설정 - android만 무료로 가능하니 참고
Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // [중요] 안드로이드 13 이상을 위한 권한 요청 팝업
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ 알림 권한 허용됨');

    if (Platform.isIOS) {
      // iOS의 경우 APNS 토큰이 설정될 때까지 기다려야 하는 경우가 있음
      String? apnsToken = await messaging.getAPNSToken();
      if (apnsToken == null) {
        print('아직 APNS 토큰이 설정되지 않았습니다.');
        return;
      }
    }
    // 기기 고유 토큰(Token) 가져오기
    String? token = await messaging.getToken();

    print('-------------------------');
    print('🚀 내 FCM 토큰: $token');
    print('-------------------------');

    // 이 토큰을 복사해서 메모장에 적어두세요! 나중에 테스트할 때 씁니다.
  } else {
    print('❌ 알림 권한 거부됨');
  }
}
