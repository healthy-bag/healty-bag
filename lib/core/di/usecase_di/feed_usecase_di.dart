import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:healthy_bag/domain/usecase/feed_usecase.dart';

final feedUseCaseProvider = Provider<FeedUseCase>((ref) {
  return FeedUseCase(repository: ref.watch(feedRepositoryProvider));
});
