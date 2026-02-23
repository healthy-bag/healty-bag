// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_block_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalBlockViewModel)
final globalBlockViewModelProvider = GlobalBlockViewModelProvider._();

final class GlobalBlockViewModelProvider
    extends $StreamNotifierProvider<GlobalBlockViewModel, List<String>> {
  GlobalBlockViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalBlockViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalBlockViewModelHash();

  @$internal
  @override
  GlobalBlockViewModel create() => GlobalBlockViewModel();
}

String _$globalBlockViewModelHash() =>
    r'a72e6593657a40b36dff0ebc52359066b7c472dd';

abstract class _$GlobalBlockViewModel extends $StreamNotifier<List<String>> {
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
