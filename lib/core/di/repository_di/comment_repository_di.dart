import 'package:healthy_bag/core/di/data_source_di/comment_data_source_di.dart';
import 'package:healthy_bag/data/repositories_impl/comment_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/comment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_repository_di.g.dart';

@riverpod
CommentRepository commentRepository(Ref ref) {
  final commentDataSource = ref.read(commentDataSourceProvider);
  return CommentRepositoryImpl(commentDataSource);
}
