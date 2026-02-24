import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/theme/tokens/app_colors.dart';
import 'package:healthy_bag/presentation/my/widgets/profile-edit-bottom_sheet.dart';
import 'package:healthy_bag/presentation/notifier/global_follow_notifier.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class Button extends ConsumerWidget {
  const Button({super.key, required this.targetUid});

  final String targetUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(globalUserViewModelProvider);
    final followingUsers = ref.watch(globalFollowProvider);

    final bool isMe = currentUser?.uid == targetUid;
    if (isMe) {
      return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => ProfileEditBottomSheet(user: currentUser!),
            );
          },
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
        ),
      );
    }
    final bool isFollowing = followingUsers.value?.contains(targetUid) ?? false;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          if (currentUser == null) return;

          if (isFollowing) {
            await ref
                .read(globalFollowProvider.notifier)
                .unfollow(currentUser, targetUid);
          } else {
            await ref
                .read(globalFollowProvider.notifier)
                .follow(currentUser, targetUid);
          }
        },
        child: Container(
          height: 36,
          width: 220,
          margin: const EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            color: isFollowing ? Colors.grey[400] : AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              isFollowing ? '팔로잉' : '팔로우',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
