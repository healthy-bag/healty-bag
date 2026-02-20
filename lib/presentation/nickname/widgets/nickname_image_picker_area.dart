import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

class NicknameImagePickerArea extends ConsumerWidget {
  const NicknameImagePickerArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);

    return state.image != null ? ImagePickerArea() : NoImagePickerArea();
  }
}

class NoImagePickerArea extends ConsumerWidget {
  const NoImagePickerArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final imagePicker = ImagePicker();
        final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          ref
              .read(nicknameViewmodelProvider.notifier)
              .setImage(File(xFile.path));
        }
      },
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: 100,
              color: Colors.grey[500],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 25,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickerArea extends ConsumerWidget {
  const ImagePickerArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.file(
            state.image!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () async {
              ref.read(nicknameViewmodelProvider.notifier).resetImage();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.remove, size: 25, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
