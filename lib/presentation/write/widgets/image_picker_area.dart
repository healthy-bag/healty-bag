import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/write/write_view_model.dart';
import 'package:material_symbols_icons/symbols.dart';

class ImagePickerArea extends ConsumerWidget {
  const ImagePickerArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(writeViewModelProvider);
    return GestureDetector(
      onTap: () async {
        await ref.read(writeViewModelProvider.notifier).pickImage();
      },
      child: state.imagePath != null
          ? Container(
              width: 340,
              height: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.file(File(state.imagePath!), fit: BoxFit.cover),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade200,
              ),
              width: 260,
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.add_rounded,
                    size: 160,
                    weight: 160,
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    '사진을 추가해주세요',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
                  ),
                ],
              ),
            ),
    );
  }
}
