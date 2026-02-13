import 'package:healthy_bag/data/data_source/feed_data_source/feed_data_source.dart';
import 'package:healthy_bag/data/data_source/feed_data_source/remote/feed_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_data_source_di.g.dart';

@riverpod
FeedDataSource feedDataSource(Ref ref) {
  return FeedDataSourceImpl();
}
