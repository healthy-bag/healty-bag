import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/presentation/write/widgets/content_input_field.dart';
import 'package:healthy_bag/presentation/write/widgets/image_picker_area.dart';
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
    // final isLoading = ref.watch(
    //   writeViewModelProvider.select((state) => state.isLoading),
    // );
    final state = ref.watch(writeViewModelProvider);
    final bool isValid = state.imagePath != null && state.content.isNotEmpty;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('새 게시물', style: TextStyle(fontSize: 24)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              children: [
                // 이미지 선택
                ImagePickerArea(),
                SizedBox(height: 35),
                // TagInputField(controller: tagController),
                SizedBox(height: 12),
                // 캡션 입력
                ContentInputField(controller: contentController),
                Spacer(),
                // 게시하기 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: isValid
                      ? () async {
                          await ref
                              .read(writeViewModelProvider.notifier)
                              .uploadFeed();
                          if (!context.mounted) return;
                          contentController.clear();
                          context.go('/home');
                        }
                      : null,
                  child: Text(
                    '게시하기',
                    style: TextStyle(
                      fontSize: 22,
                      color: isValid ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
        if (state.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
