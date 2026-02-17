// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalUserViewModel)
final globalUserViewModelProvider = GlobalUserViewModelProvider._();

final class GlobalUserViewModelProvider
    extends $NotifierProvider<GlobalUserViewModel, UserEntity?> {
  GlobalUserViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalUserViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalUserViewModelHash();

  @$internal
  @override
  GlobalUserViewModel create() => GlobalUserViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserEntity?>(value),
    );
  }
}

String _$globalUserViewModelHash() =>
    r'637c66451246661236c1bacf2973ee2a4c8049ca';

abstract class _$GlobalUserViewModel extends $Notifier<UserEntity?> {
  UserEntity? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserEntity?, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserEntity?, UserEntity?>,
              UserEntity?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
