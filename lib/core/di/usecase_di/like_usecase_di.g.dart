// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_usecase_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(likeUsecase)
final likeUsecaseProvider = LikeUsecaseProvider._();

final class LikeUsecaseProvider
    extends $FunctionalProvider<LikeUsecase, LikeUsecase, LikeUsecase>
    with $Provider<LikeUsecase> {
  LikeUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeUsecaseHash();

  @$internal
  @override
  $ProviderElement<LikeUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LikeUsecase create(Ref ref) {
    return likeUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LikeUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LikeUsecase>(value),
    );
  }
}

String _$likeUsecaseHash() => r'6a740260befa7cb94e9ba57fc64e5686a7aa1c61';
