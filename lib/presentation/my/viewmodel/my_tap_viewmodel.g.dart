// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tap_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyTapViewmodel)
final myTapViewmodelProvider = MyTapViewmodelProvider._();

final class MyTapViewmodelProvider
    extends $StreamNotifierProvider<MyTapViewmodel, List<FeedEntity>> {
  MyTapViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myTapViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myTapViewmodelHash();

  @$internal
  @override
  MyTapViewmodel create() => MyTapViewmodel();
}

String _$myTapViewmodelHash() => r'32f57d3bf0e4c70a226527b78c88e85c76c7e212';

abstract class _$MyTapViewmodel extends $StreamNotifier<List<FeedEntity>> {
  Stream<List<FeedEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FeedEntity>>, List<FeedEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FeedEntity>>, List<FeedEntity>>,
              AsyncValue<List<FeedEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
