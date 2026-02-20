import 'package:healthy_bag/data/data_source/like_data_source/like_data_source.dart';
import 'package:healthy_bag/data/data_source/like_data_source/remote/firebase_like_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_data_source_di.g.dart';

@riverpod
LikeDataSource likeDataSource(Ref ref) {
  return FirebaseLikeDataSourceImpl();
}
