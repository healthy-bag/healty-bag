import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/welcome/widgets/sign_in_button.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      logoUrl: 'assets/images/kakao_logo.png',
      provider: 'Kakao',
      backgroundColor: Color(0xFFFCE400),
    );
  }
}
