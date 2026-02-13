import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthy_bag/data/dto/user_dto.dart';
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

  @override
  Future<void> registerUser(UserDTO user) async {
    try {
      final docRef = firestore.collection('users').doc(user.uid);
      await docRef.set(user.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<bool> checkNickname(String nickname) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .where('nickname', isEqualTo: nickname)
          .limit(1)
          .get();
      return querySnapshot.docs.isEmpty;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<String> uploadProfileImage(File file) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().microsecondsSinceEpoch}');

      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();

      return downloadUrl;
    } on FirebaseException {
      rethrow;
    }
  }
}
