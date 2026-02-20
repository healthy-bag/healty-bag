import 'package:flutter/material.dart';
import 'package:healthy_bag/core/theme/tokens/app_spacing.dart';
import 'package:healthy_bag/presentation/nickname/widgets/nickname_image_picker_area.dart';
import 'package:healthy_bag/presentation/nickname/widgets/nickname_textfield.dart';
import 'package:healthy_bag/presentation/nickname/widgets/sign_up_button.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';

class NicknamePage extends StatelessWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HealthyBagLogo(),
              AppSpacing.height48,
              NicknameImagePickerArea(),
              AppSpacing.height24,
              Text(
                "닉네임을 입력해주세요.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.height4,
              Text(
                '영문 3자 이상 + 숫자 1자 이상 포함',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              AppSpacing.height24,
              NicknameTextfield(),
              AppSpacing.height24,
              SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
