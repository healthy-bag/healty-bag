import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/write/widgets/content_input_field.dart';
import 'package:healthy_bag/presentation/write/widgets/image_picker_area.dart';
import 'package:healthy_bag/presentation/write/widgets/tag_input_field.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';

class WritePage extends ConsumerWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(writeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 추가', style: TextStyle(fontSize: 24)),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(writeViewModelProvider.notifier).uploadImage();
            },
            child: const Text(
              '확인',
              style: TextStyle(fontSize: 18, color: Colors.pink),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImagePickerArea(),
            SizedBox(height: 35),
            TagInputField(),
            SizedBox(height: 12),
            ContentInputField(),
          ],
        ),
      ),
    );
  }
}
