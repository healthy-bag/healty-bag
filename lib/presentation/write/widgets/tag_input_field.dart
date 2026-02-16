import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';

class TagInputField extends ConsumerWidget {
  const TagInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(writeViewModelProvider.notifier);
    return TextField(
      controller: vm.tagController,
      onChanged: (value) {
        vm.updateTag(value);
      },
      style: TextStyle(fontSize: 22),
      decoration: InputDecoration(
        hintText: '#태그를 추가하세요',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
