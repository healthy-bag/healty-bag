import 'package:healthy_bag/data/data_source/auth_data_source/auth_data_source.dart';
import 'package:healthy_bag/data/data_source/user_data_source/user_data_source.dart';
import 'package:healthy_bag/domain/entity/user_entity.dart';
import 'package:healthy_bag/domain/repositories/auth_repository.dart';

class GoogleAuthRepositoryImpl implements AuthRepository {
  GoogleAuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required UserDataSource userDataSource,
  }) : _authDataSource = authDataSource,
       _userDataSource = userDataSource;

  final AuthDataSource _authDataSource;
  final UserDataSource _userDataSource;

  @override
  Future<UserEntity?> signIn() async {
    final userCredential = await _authDataSource.getUserCredential();
    if (userCredential != null) {
      final userDTO = await _userDataSource.fetchUserInfo(
        userCredential.user!.uid,
      );
      return UserEntity(
        uid: userDTO!.uid,
        nickname: userDTO.nickname,
        followerCount: userDTO.followerCount,
        followingCount: userDTO.followingCount,
        feedCount: userDTO.feedCount,
        profileUrl: userDTO.profileUrl,
      );
    }
    return null;
  }
}
