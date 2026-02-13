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
    extends $AsyncNotifierProvider<NicknameViewmodel, NicknameState> {
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
}

String _$nicknameViewmodelHash() => r'a55464c19596dfd72db731c283bf34d83bacd83b';

abstract class _$NicknameViewmodel extends $AsyncNotifier<NicknameState> {
  FutureOr<NicknameState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NicknameState>, NicknameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NicknameState>, NicknameState>,
              AsyncValue<NicknameState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
