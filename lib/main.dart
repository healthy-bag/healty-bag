import 'package:flutter/material.dart';
import 'package:healthy_bag/core/theme/app_theme.dart';
import 'package:healthy_bag/presentation/%20write/write_page.dart';
import 'package:healthy_bag/presentation/nickname/nickname_page.dart';
import 'package:healthy_bag/presentation/welcome/welcome_page.dart';
import 'package:healthy_bag/presentation/widgets/home/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Bag',
      theme: AppTheme.lightTheme,
      home: NicknamePage()
    );
  }
}
