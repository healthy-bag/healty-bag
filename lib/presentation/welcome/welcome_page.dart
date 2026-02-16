import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/domain/models/auth_result.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:healthy_bag/presentation/welcome/viewmodel/welcome_view_model.dart';
import 'package:healthy_bag/presentation/welcome/widgets/google_login_button.dart';
import 'package:healthy_bag/presentation/welcome/widgets/kakao_login_button.dart';
import 'package:healthy_bag/presentation/widgets/healthy_bag_logo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(welcomeViewModelProvider);
    ref.listen(welcomeViewModelProvider, (previous, next) {
      next.when(
        data: (data) {
          switch (data) {
            case AuthSuccess():
              ref.read(globalUserViewModelProvider.notifier).setUser(data.user);
              context.goNamed('home');
            case NewUser():
              context.goNamed('nickname');
            case AuthFailure():
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(message: data.message),
              );
            case null:
              break;
          }
        },
        error: (error, stack) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: error.toString()),
          );
        },
        loading: () {
          const Center(child: CircularProgressIndicator());
        },
      );
    });

    return state.when(
      data: (data) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                HealthyBagLogo(),
                Spacer(flex: 1),
                GoogleLoginButton(
                  onPressed: () async {
                    await ref
                        .read(welcomeViewModelProvider.notifier)
                        .googleLogin();
                  },
                ),
                KakaoLoginButton(
                  onPressed: () async {
                    await ref
                        .read(welcomeViewModelProvider.notifier)
                        .kakaoLogin();
                  },
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
