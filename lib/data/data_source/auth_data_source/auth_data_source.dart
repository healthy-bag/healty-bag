import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/domain/models/social_type.dart';

abstract class AuthDataSource {
  Future<OAuthCredential?> getCredential(SocialType type);
}
