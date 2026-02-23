import 'package:flutter/material.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 36,
        width: 220,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: AppColors.lightPrimary,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            '프로필 편집',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
