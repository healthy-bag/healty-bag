// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_like_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalLikeNotifier)
final globalLikeProvider = GlobalLikeNotifierProvider._();

final class GlobalLikeNotifierProvider
    extends $StreamNotifierProvider<GlobalLikeNotifier, List<String>> {
  GlobalLikeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalLikeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalLikeNotifierHash();

  @$internal
  @override
  GlobalLikeNotifier create() => GlobalLikeNotifier();
}

String _$globalLikeNotifierHash() =>
    r'bbc18bd49cd19bce710b5b6a180142d381331741';

abstract class _$GlobalLikeNotifier extends $StreamNotifier<List<String>> {
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
