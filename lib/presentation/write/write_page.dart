import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/write/widgets/content_input_field.dart';
import 'package:healthy_bag/presentation/write/widgets/image_picker_area.dart';
import 'package:healthy_bag/presentation/write/widgets/tag_input_field.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final contentController = TextEditingController();
  final tagController = TextEditingController();

  @override
  void dispose() {
    contentController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      writeViewModelProvider.select((state) => state.isLoading),
    );
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('게시물 추가', style: TextStyle(fontSize: 24)),
            actions: [
              TextButton(
                onPressed: () async {
                  await ref.read(writeViewModelProvider.notifier).uploadFeed();
                  if (!context.mounted) return;
                  contentController.clear();
                  tagController.clear();
                  context.go('/home');
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
                TagInputField(controller: tagController),
                SizedBox(height: 12),
                ContentInputField(controller: contentController),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
