import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/data_source/user_data_source/user_data_source.dart';
import 'package:healthy_bag/data/dto/user_dto.dart';
import 'package:healthy_bag/domain/entities/user_entity.dart';
import 'package:healthy_bag/domain/models/follow_result.dart';
import 'package:healthy_bag/domain/models/save_image_result.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl({required UserDataSource userDataSource})
    : _userDataSource = userDataSource;

  @override
  Future<UserEntity?> getUserInfo(String uid) async {
    final userDTO = await _userDataSource.fetchUserInfo(uid); // 값 반환 X

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
  Future<void> registerUser(UserEntity user) async {
    final userDTO = UserDTO(
      uid: user.uid,
      nickname: user.nickname,
      followerCount: user.followerCount,
      followingCount: user.followingCount,
      feedCount: user.feedCount,
      profileUrl: user.profileUrl,
    );
    await _userDataSource.registerUser(userDTO);
  }

  @override
  Future<bool> checkNickname(String nickname) async {
    return await _userDataSource.checkNickname(nickname);
  }

  @override
  Future<SaveImageResult> uploadProfileImage(File file) async {
    try {
      final imageUrl = await _userDataSource.uploadProfileImage(file);
      return SaveImageSuccess(imageUrl: imageUrl);
    } on Exception catch (e) {
      return SaveImageFailure(message: e.toString());
    }
  }

  @override
  Future<void> addfeedCount(String uid) async {
    await _userDataSource.addfeedCount(uid);
  }

  @override
  Stream<List<String>> fetchBlockedUsers(String uid) {
    return _userDataSource.fetchBlockedUsers(uid);
  }

  @override
  Future<void> blockUser(String uid, String blockedId) async {
    await _userDataSource.blockUser(uid, blockedId);
  }

  @override
  Future<void> unblockUser(String uid, String blockedId) async {
    await _userDataSource.unblockUser(uid, blockedId);
  }

  @override
  Future<void> updateUserData(UserEntity user, {File? imageFile}) async {
    String? newProfileUrl;
    if (imageFile != null) {
      newProfileUrl = await _userDataSource.uploadProfileImage(imageFile);
    }

    final updateData = {
      'nickname': user.nickname,
      if (newProfileUrl != null) 'profileUrl': newProfileUrl,
    };
    await _userDataSource.updateUserData(user.uid, updateData);
    if (imageFile != null && user.profileUrl != null) {
      try {
        await _userDataSource.delete(user.profileUrl!);
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<FollowResult> follow(UserEntity user, String followedId) async {
    try {
      await _userDataSource.follow(user.uid, followedId);
      await _userDataSource.updateUserData(user.uid, {
        'followingCount': FieldValue.increment(1),
      });
      await _userDataSource.updateUserData(followedId, {
        'followerCount': FieldValue.increment(1),
      });
      return FollowSuccess();
    } catch (e) {
      return FollowFailure(message: e.toString());
    }
  }

  @override
  Future<FollowResult> unfollow(UserEntity user, String followedId) async {
    try {
      await _userDataSource.unfollow(user.uid, followedId);
      await _userDataSource.updateUserData(user.uid, {
        'followingCount': FieldValue.increment(-1),
      });
      await _userDataSource.updateUserData(followedId, {
        'followerCount': FieldValue.increment(-1),
      });
      return FollowSuccess();
    } catch (e) {
      return FollowFailure(message: e.toString());
    }
  }

  @override
  Future<FollowResult> fetchFollowingUsers(String uid) async {
    try {
      final followingUsers = _userDataSource.fetchFollowingUsers(uid);
      return FetchFollowingUsersSuccess(data: followingUsers);
    } catch (e) {
      return FollowFailure(message: e.toString());
    }
  }
}
