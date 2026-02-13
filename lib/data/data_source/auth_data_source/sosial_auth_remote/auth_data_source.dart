import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<OAuthCredential?> getCredential(SocialType type) async {
    try {
      OAuthCredential credential;

      switch (type) {
        case SocialType.google:
          final googleUser = await GoogleSignIn().signIn(); // 로그인 UI 띄우기

          if (googleUser == null) return null;
          final googleAuth =
              await googleUser.authentication; // 선택된 계정으로부터 토큰 발급
          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ); // Firebase용 로그인용 자격 증명 생성
        case SocialType.kakao:
          OAuthToken token = await isKakaoTalkInstalled()
              ? await UserApi.instance
                    .loginWithKakaoTalk() // 카카오톡이 설치 되어있을 때, 바로 카카오톡 딥링크
              : await UserApi.instance
                    .loginWithKakaoAccount(); // 카카오톡이 설치 되어 있지 않을 때, 웹뷰로 로그인

          if (token.idToken == null) {
            throw Exception('Kakao ID Token is missing.');
          }

          credential = OAuthProvider(
            'oidc.kakao',
          ).credential(idToken: token.idToken!, accessToken: token.accessToken);
      }

      return credential;
    } catch (e) {
      print('Login Error: $e');
      if (e is PlatformException && e.code == 'CANCELED') {
        return null;
      }
      rethrow;
    }
  }
}
