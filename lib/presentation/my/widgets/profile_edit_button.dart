import 'package:flutter/material.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 36.0),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 34,
      width: 200,
      child: Center(
        child: Text(
          '프로필 수정',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
