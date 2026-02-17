import 'package:healthy_bag/data/data_source/comment_data_source/comment_data_source.dart';
import 'package:healthy_bag/data/data_source/comment_data_source/remote/comment_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_data_source_di.g.dart';

@riverpod
CommentDataSource commentDataSource(Ref ref) {
  return CommentDataSourceImpl();
}
