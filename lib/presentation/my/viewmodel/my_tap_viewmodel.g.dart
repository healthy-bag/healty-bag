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
    extends $NotifierProvider<MyTapViewmodel, List<String>?> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>?>(value),
    );
  }
}

String _$myTapViewmodelHash() => r'7b349c68938a32d29548c7da56f0c00a8364ef4c';

abstract class _$MyTapViewmodel extends $Notifier<List<String>?> {
  List<String>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<String>?, List<String>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>?, List<String>?>,
              List<String>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
