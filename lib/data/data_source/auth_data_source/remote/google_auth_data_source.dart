import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';

class GoogleAuthDataSource implements AuthDataSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  GoogleAuthDataSource({GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
    : _googleSignIn = googleSignIn ?? GoogleSignIn(),
      _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserCredential?> getUserCredential() async {
    try {
      final googleUser = await _googleSignIn.signIn(); // 로그인 UI 띄우기

      if (googleUser == null) return null;
      final googleAuth = await googleUser.authentication; // 선택된 계정으로부터 토큰 발급
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); // Firebase용 로그인용 자격 증명 생성
      return await _firebaseAuth.signInWithCredential(
        credential,
      ); // 발급받은 토큰으로 파이어베이스 로그인
    } catch (e) {
      rethrow;
    }
  }
}
