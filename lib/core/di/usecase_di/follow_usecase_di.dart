import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/di/repository_di/user_repository_di.dart';
import 'package:healthy_bag/domain/usecase/follow_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_usecase_di.g.dart';

@riverpod
FollowUsecase followUsecase(Ref ref) {
  return FollowUsecase(ref.read(userRepositoryProvider));
}
