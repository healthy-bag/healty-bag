import 'dart:io';

import 'package:healthy_bag/core/di/usecase_di/register_usecase_di.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_viewmodel.g.dart';

class NicknameState {
  final String uid;
  final String nickname;
  final File? image;

  NicknameState({required this.uid, this.nickname = '', this.image});

  NicknameState copyWith({String? uid, String? nickname, File? image}) {
    return NicknameState(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      image: image ?? this.image,
    );
  }
}

@riverpod
class NicknameViewmodel extends _$NicknameViewmodel {
  @override
  NicknameState build() {
    final uid = ref.read(globalUserViewModelProvider.notifier).state!.uid;
    return NicknameState(uid: uid);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  // XFile xfile param
  void setImage(File image) {
    state = state.copyWith(image: image);
  }

  void resetImage() {
    state = state.copyWith(image: null);
  }

  Future<void> signUp() async {
    final newValue = state;

    final isAvailable = await ref
        .read(registerUsecaseProvider)
        .register(
          uid: newValue.uid,
          nickname: newValue.nickname,
          profileImage: newValue.image,
        );
    if (isAvailable) {
      await ref
          .read(globalUserViewModelProvider.notifier)
          .setUserById(newValue.uid);
    }
  }
}
