import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/nickname/nickname_view_model.dart';

class StartButton extends ConsumerWidget {
  const StartButton({super.key, required this.state, required this.uid});

  final NicknameState state;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isValid
            ? () async {
                final user = await ref
                    .read(nicknameViewModelProvider.notifier)
                    .saveUser(uid);
                if (context.mounted) {
                  context.go('/home', extra: user);
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: state.isValid ? Colors.pinkAccent : Colors.white10,
          foregroundColor: state.isValid ? Colors.white : Colors.white38,
          elevation: state.isValid ? 4 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state.isLoading
            ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
            : const Text("시작하기"),
      ),
    );
  }
}
