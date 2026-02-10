import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_bag/data/DTO/user_dto.dart';
import 'package:healthy_bag/data/data_source/user_data_source/user_data_source.dart';

class FirebaseUserDataSourceImpl implements UserDataSource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<UserDTO?> fetchUserInfo(String uid) async {
    final userDoc = await firestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      return UserDTO.fromJson(userData!);
    }
    return null;
  }
}
