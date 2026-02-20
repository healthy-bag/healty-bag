import 'package:healthy_bag/core/di/data_source_di/like_data_source_di.dart';
import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/repositories_impl/like_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/like_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_repository_di.g.dart';

@riverpod
LikeRepository likeRepository(Ref ref) {
  final likeDataSource = ref.read(likeDataSourceProvider);
  return LikeRepositoryImpl(likeDataSource: likeDataSource);
}
