import 'dart:io';

import 'package:healthy_bag/domain/models/save_image_result.dart';
import 'package:healthy_bag/domain/repositories/user_repository.dart';

class SaveImageUsecase {
  final UserRepository _userRepository;

  SaveImageUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<SaveImageResult> execute(File file) async {
    final result = await _userRepository.uploadProfileImage(file);
    return result;
  }
}
