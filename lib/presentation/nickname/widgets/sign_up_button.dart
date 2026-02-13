import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.value?.isValid ?? false
            ? () async {
                await ref.read(nicknameViewmodelProvider.notifier).signUp();
                if (context.mounted && state.value!.isAvailable) {
                  context.goNamed('home');
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: state.value?.isValid ?? false
              ? Colors.pinkAccent
              : Colors.transparent,
          foregroundColor: state.value?.isValid ?? false
              ? Colors.white
              : Colors.transparent,
          elevation: state.value?.isValid ?? false ? 4 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "시작하기",
          style: TextStyle(
            color: state.value?.isValid ?? false
                ? Colors.white
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
