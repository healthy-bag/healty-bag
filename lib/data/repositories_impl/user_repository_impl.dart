import 'package:healthy_bag/data/DTO/user_dto.dart';
import 'package:healthy_bag/data/data_source/user_data_source/user_data_source.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl({required UserDataSource userDataSource})
    : _userDataSource = userDataSource;

  @override
  Future<UserEntity?> getUserInfo(String uid) async {
    final userDTO = await _userDataSource.fetchUserInfo(uid);
    if (userDTO == null) return null;
    return UserEntity(
      uid: userDTO.uid,
      nickname: userDTO.nickname,
      followerCount: userDTO.followerCount,
      followingCount: userDTO.followingCount,
      feedCount: userDTO.feedCount,
      profileUrl: userDTO.profileUrl,
    );
  }

  @override
  Future<void> saveUserInfo(UserEntity user) async {
    final userDTO = UserDTO(
      uid: user.uid,
      nickname: user.nickname,
      followerCount: user.followerCount,
      followingCount: user.followingCount,
      feedCount: user.feedCount,
      profileUrl: user.profileUrl,
    );
    await _userDataSource.saveUserInfo(userDTO);
  }
}
