import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/nickname/viewmodel/nickname_viewmodel.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NicknameImagePickerArea extends ConsumerWidget {
  const NicknameImagePickerArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nicknameViewmodelProvider);
    final viewModel = ref.read(nicknameViewmodelProvider.notifier);

    ref.listen(nicknameViewmodelProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message: "알 수 없는 에러가 발생했습니다."),
        );
      }
    });

    return state.when(
      data: (data) => GestureDetector(
        onTap: () async {
          await viewModel.setImage(); // 이미지 선택 함수 호출
        },
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                image: state.value!.imagePath != null
                    ? DecorationImage(
                        image: FileImage(File(state.value!.imagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null, // 이미지가 없으면 배경색만 표시
              ),
              // 이미지가 없을 때 기본 아이콘 표시
              child: state.value!.imagePath == null
                  ? Icon(Icons.person, size: 100, color: Colors.grey.shade500)
                  : null,
            ),
            // 카메라 아이콘 배지 (우측 하단)
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: state.value!.imagePath == null
                    ? const Icon(
                        Icons.camera_alt_outlined,
                        size: 25,
                        color: Colors.black54,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
      error: (Object error, StackTrace stackTrace) {
        return const Center(child: Text("에러"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
