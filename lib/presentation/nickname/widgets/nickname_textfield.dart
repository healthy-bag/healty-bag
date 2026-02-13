import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';

class NicknameTextfield extends ConsumerWidget {
  const NicknameTextfield({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);
    return TextField(
      onChanged: (value) {
        ref.read(nicknameViewmodelProvider.notifier).setNickname(value);
      },
      maxLength: 12,
      decoration: InputDecoration(
        // labelText: "닉네임",
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: state.value?.isValid ?? false
              ? BorderSide(color: Colors.pinkAccent, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}
