import 'package:healthy_bag/core/di/usecase_di/register_usecase_di.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_viewmodel.g.dart';

class NicknameState {
  final String nickname;
  final bool isAvailable;
  final bool isValid;
  final String? imagePath;

  NicknameState({
    this.nickname = '',
    this.isAvailable = false,
    this.isValid = false,
    this.imagePath,
  });

  NicknameState copyWith({
    String? nickname,
    bool? isAvailable,
    bool? isValid,
    String? imagePath,
  }) {
    return NicknameState(
      nickname: nickname ?? this.nickname,
      isAvailable: isAvailable ?? this.isAvailable,
      isValid: isValid ?? this.isValid,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

@riverpod
class NicknameViewmodel extends _$NicknameViewmodel {
  @override
  Future<NicknameState> build() async {
    return NicknameState();
  }

  void setNickname(String nickname) {
    int letterCount = nickname.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    bool hasNumber = nickname.contains(RegExp(r'[0-9]'));
    final isValid = letterCount >= 3 && hasNumber;
    state = AsyncData(
      state.value!.copyWith(nickname: nickname, isValid: isValid),
    );
  }

  // XFile xfile param
  Future<void> setImage() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    state = AsyncData(state.value!.copyWith(imagePath: xFile.path));
  }

  Future<void> signUp() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final isAvailable = await ref
          .read(registerUsecaseProvider)
          .register(
            nickname: state.value!.nickname,
            imagePath: state.value!.imagePath,
          );
      return state.value!.copyWith(isAvailable: isAvailable);
    });
  }
}
