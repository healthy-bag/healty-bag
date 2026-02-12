import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/firebase_auth_remote/auth_remote_data_source.dart';
import 'package:healthy_bag/domain/models/social_type.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';

// Auth DataSource에서 가져온 UserCredential을 기반으로 AuthResult를 usecase로 반환
// 1. entity 자체를 던져줄건지 -> heavy한가?
// 2. uid만 던져줄건지 -> domain 구조에 맞지 않나?
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
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
