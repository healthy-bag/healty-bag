import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/welcome/widgets/sign_in_button.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      logoUrl: 'assets/images/google_logo.png',
      provider: 'Google',
      backgroundColor: Colors.white,
    );
  }
}
