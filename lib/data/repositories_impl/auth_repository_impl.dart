import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/domain/entity/user_entity.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';

// Auth DataSource에서 가져온 UserCredential을 기반으로 AuthResult를 usecase로 반환
// 1. entity 자체를 던져줄건지 -> heavy한가?
// 2. uid만 던져줄건지 -> domain 구조에 맞지 않나?
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource;

  final AuthDataSource _authDataSource;

  @override
  Future<UserEntity?> signIn() async {
    final userCredential = await _authDataSource
        .getUserCredential(); // 따로 함수 작성

    if (userCredential != null) {
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
  }
}
