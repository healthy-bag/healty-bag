import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/welcome/widgets/google_login_button.dart';
import 'package:healthy_bag/presentation/welcome/widgets/kakao_login_button.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          HealthyBagLogo(),
          Spacer(flex: 1),
          GoogleLoginButton(),
          KakaoLoginButton(),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
