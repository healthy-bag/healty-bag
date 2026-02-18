import 'package:flutter/material.dart';
import 'package:healthy_bag/core/di/repository_di/feed_repository_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_tap_viewmodel.g.dart';

@riverpod
class MyTapViewmodel extends _$MyTapViewmodel {
  @override
  List<String>? build() {
    return null;
  }

  void setThumbnail(String userId) async {
    state = await ref.watch(feedRepositoryProvider).fetchMyFeedUrls(userId);
  }
}
