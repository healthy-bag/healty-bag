// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_follow_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalFollowNotifier)
final globalFollowProvider = GlobalFollowNotifierProvider._();

final class GlobalFollowNotifierProvider
    extends $StreamNotifierProvider<GlobalFollowNotifier, List<String>> {
  GlobalFollowNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalFollowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalFollowNotifierHash();

  @$internal
  @override
  GlobalFollowNotifier create() => GlobalFollowNotifier();
}

String _$globalFollowNotifierHash() =>
    r'9423df606ec3daa093fd9756ca4aa61e384fb918';

abstract class _$GlobalFollowNotifier extends $StreamNotifier<List<String>> {
  Stream<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
