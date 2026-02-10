import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthy_bag/firebase_options.dart';
import 'package:healthy_bag/presentation/write/write_page.dart';
import 'package:healthy_bag/core/theme/app_theme.dart';

import 'package:healthy_bag/presentation/welcome/welcome_page.dart';
import 'package:healthy_bag/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Bag',
      theme: AppTheme.lightTheme,
      // home: WelcomePage(),
      home: WritePage(),
    );
  }
}
