import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';

class ContentInputField extends ConsumerWidget {
  const ContentInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(writeViewModelProvider.notifier);
    return TextField(
      controller: vm.contentController,
      onChanged: (value) {
        vm.updateContent(value);
      },
      style: TextStyle(fontSize: 22),
      maxLines: 4,
      decoration: InputDecoration(
        hintText: '내용을 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
