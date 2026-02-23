import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class Button extends ConsumerWidget {
  const Button({super.key, required this.targetUid});

  final String targetUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(globalUserViewModelProvider);
    final bool isMe = currentUser?.uid == targetUid;
    if (isMe) {
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
            '팔로우',
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
