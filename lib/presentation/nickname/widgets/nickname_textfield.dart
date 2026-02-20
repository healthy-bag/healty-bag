import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/utils/register_utils.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';

class NicknameTextfield extends ConsumerWidget {
  const NicknameTextfield({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);

    return TextField(
      onChanged: (value) {
        if (RegisterUtils.isValidNickname(value)) {
          ref.read(nicknameViewmodelProvider.notifier).setNickname(value);
        }
        return;
      },
      maxLength: 12,
      decoration: InputDecoration(
        hint: Text("닉네임을 입력해주세요."),
        // labelText: "닉네임",
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: RegisterUtils.isValidNickname(state.nickname)
              ? BorderSide(color: Colors.pinkAccent, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}
