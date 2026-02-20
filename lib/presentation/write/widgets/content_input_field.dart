import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';

class ContentInputField extends ConsumerWidget {
  const ContentInputField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(writeViewModelProvider.notifier);
    return TextField(
      controller: controller,
      onChanged: (value) {
        vm.updateContent(value);
      },
      style: TextStyle(fontSize: 22),
      maxLines: 4,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '캡션 추가',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
