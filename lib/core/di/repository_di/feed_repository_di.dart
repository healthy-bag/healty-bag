import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/data/data_source/feed_data_source/remote/feed_data_source_impl.dart';
import 'package:healthy_bag/data/repositories_impl/feed_repository_impl.dart';
import 'package:healthy_bag/domain/repositories/feed_repository.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl(feedDataSource: FeedDataSourceImpl());
});
