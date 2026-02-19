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
    extends $StreamNotifierProvider<MyTapViewmodel, List<String>> {
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

String _$myTapViewmodelHash() => r'e3cc34e30f7b082a444061fceedb46059a9e04a5';

abstract class _$MyTapViewmodel extends $StreamNotifier<List<String>> {
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
