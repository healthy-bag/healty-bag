import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/firebase_auth_remote/auth_remote_data_source.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authDataSource = authDataSource,
       _authRemoteDataSource = authRemoteDataSource;

  final AuthDataSource _authDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<UserEntity?> signIn(SocialType type) async {
    try {
      final UserCredential userCredential;
      final credential = await _authDataSource.getCredential(type);
      if (credential == null) return null;
      userCredential = await _authRemoteDataSource.signIn(credential);

      if (userCredential.user != null) {
        return UserEntity(
          uid: userCredential.user!.uid,
          nickname: "",
          followerCount: 0,
          followingCount: 0,
          feedCount: 0,
          profileUrl: "",
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
    return null;
  }

  @override
  Future<String?> getCurrentUid() async {
    return _authRemoteDataSource.getCurrentUid();
  }
}
