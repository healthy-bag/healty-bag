// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_usecase_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(followUsecase)
final followUsecaseProvider = FollowUsecaseProvider._();

final class FollowUsecaseProvider
    extends $FunctionalProvider<FollowUsecase, FollowUsecase, FollowUsecase>
    with $Provider<FollowUsecase> {
  FollowUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'followUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$followUsecaseHash();

  @$internal
  @override
  $ProviderElement<FollowUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FollowUsecase create(Ref ref) {
    return followUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FollowUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FollowUsecase>(value),
    );
  }
}

String _$followUsecaseHash() => r'a89a1d8774123d536df6fd704837af6f50f05e28';
