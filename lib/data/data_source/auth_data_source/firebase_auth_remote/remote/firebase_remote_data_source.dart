import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/firebase_auth_remote/auth_remote_data_source.dart';

class FirebaseRemoteDataSource implements AuthRemoteDataSource {
  FirebaseRemoteDataSource({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential> signIn(OAuthCredential credential) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
