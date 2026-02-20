// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NicknameViewmodel)
final nicknameViewmodelProvider = NicknameViewmodelProvider._();

final class NicknameViewmodelProvider
    extends $NotifierProvider<NicknameViewmodel, NicknameState> {
  NicknameViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nicknameViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nicknameViewmodelHash();

  @$internal
  @override
  NicknameViewmodel create() => NicknameViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NicknameState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NicknameState>(value),
    );
  }
}

String _$nicknameViewmodelHash() => r'f6042218bd5fb21c43b09565effce5912a1bd440';

abstract class _$NicknameViewmodel extends $Notifier<NicknameState> {
  NicknameState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NicknameState, NicknameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NicknameState, NicknameState>,
              NicknameState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
