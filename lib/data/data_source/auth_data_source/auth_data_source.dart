import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<UserCredential?> getUserCredential();
}
