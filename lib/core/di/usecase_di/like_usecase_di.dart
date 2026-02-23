import 'package:healthy_bag/core/di/repository_di/like_repository_di.dart';
import 'package:healthy_bag/domain/usecase/like_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_usecase_di.g.dart';

@riverpod
LikeUsecase likeUsecase(Ref ref) =>
    LikeUsecase(ref.read(likeRepositoryProvider));
