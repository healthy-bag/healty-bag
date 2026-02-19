import 'package:healthy_bag/core/di/data_source_di/feed_data_source_di.dart';
import 'package:healthy_bag/data/repositories_impl/feed_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_repository_di.g.dart';

@riverpod
FeedRepository feedRepository(Ref ref) {
  final feedDataSource = ref.read(feedDataSourceProvider);
  return FeedRepositoryImpl(feedDataSource: feedDataSource);
}
