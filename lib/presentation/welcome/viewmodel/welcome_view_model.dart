import 'package:healthy_bag/core/di/usecase_di/login_usecase_di.dart';
import 'package:healthy_bag/domain/models/auth_result.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_view_model.g.dart';

@riverpod
class WelcomeViewModel extends _$WelcomeViewModel {
  @override
  Future<AuthResult?> build() async {
    return null;
  }

  Future<void> googleLogin() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await ref.read(loginUsecaseProvider).login(SocialType.google);
    });
  }

  Future<void> kakaoLogin() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await ref.read(loginUsecaseProvider).login(SocialType.kakao);
    });
  }
}
