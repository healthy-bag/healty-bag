import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/di/usecase_di/login_usecase_di.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _opacity = 1.0);
    });

    final results = await Future.wait([
      ref.read(loginUsecaseProvider).loginCheck(),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    final user = results[0];
    if (!mounted) return;

    if (user != null) {
      ref.read(globalUserViewModelProvider.notifier).setUser(user);
      context.go('/home');
    } else {
      context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
        child: Center(child: const HealthyBagLogo()),
      ),
    );
  }
}
