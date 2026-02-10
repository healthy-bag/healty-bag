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
      child: state.localPath != null
          ? Container(
              width: double.infinity,
              height: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.file(File(state.localPath!), fit: BoxFit.cover),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              width: double.infinity,
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.add_rounded,
                    size: 200,
                    weight: 300,
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    'new',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 22),
                  ),
                ],
              ),
            ),
    );
  }
}
