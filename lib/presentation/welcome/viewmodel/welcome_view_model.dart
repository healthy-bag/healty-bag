import 'package:healthy_bag/core/di/usecase_di/login_usecase_di.dart';
import 'package:healthy_bag/domain/models/auth_result.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_view_model.g.dart';

@riverpod
class WelcomeViewModel extends _$WelcomeViewModel {
  @override
  Future<void> build() async {}

  Future<AuthResult> googleLogin() async {
    state = const AsyncLoading();

    AuthResult result = AuthFailure(message: "로그인 실패");

    state = await AsyncValue.guard(() async {
      result = await ref.read(loginUsecaseProvider).login(SocialType.google);
    });

    return result;
  }

  Future<AuthResult> kakaoLogin() async {
    state = const AsyncLoading();

    AuthResult result = AuthFailure(message: "로그인 실패");

    state = await AsyncValue.guard(() async {
      result = await ref.read(loginUsecaseProvider).login(SocialType.kakao);
    });

    return result;
  }
}
