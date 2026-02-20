import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/utils/register_utils.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: RegisterUtils.isValidNickname(state.nickname)
          ? ElevatedButton(
              onPressed: () async {
                await ref.read(nicknameViewmodelProvider.notifier).signUp();
                if (context.mounted) {
                  context.goNamed('home');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("시작하기", style: TextStyle(color: Colors.white)),
            )
          : SizedBox(),
    );
  }
}
