// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_usecase_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(googleLoginUsecase)
final googleLoginUsecaseProvider = GoogleLoginUsecaseProvider._();

final class GoogleLoginUsecaseProvider
    extends
        $FunctionalProvider<
          GoogleLoginUsecase,
          GoogleLoginUsecase,
          GoogleLoginUsecase
        >
    with $Provider<GoogleLoginUsecase> {
  GoogleLoginUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleLoginUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleLoginUsecaseHash();

  @$internal
  @override
  $ProviderElement<GoogleLoginUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleLoginUsecase create(Ref ref) {
    return googleLoginUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleLoginUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleLoginUsecase>(value),
    );
  }
}

String _$googleLoginUsecaseHash() =>
    r'303965a7d59b759dabcb8f11d47cfc2b41816a2f';

@ProviderFor(kakaoLoginUsecase)
final kakaoLoginUsecaseProvider = KakaoLoginUsecaseProvider._();

final class KakaoLoginUsecaseProvider
    extends
        $FunctionalProvider<
          KakaoLoginUsecase,
          KakaoLoginUsecase,
          KakaoLoginUsecase
        >
    with $Provider<KakaoLoginUsecase> {
  KakaoLoginUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kakaoLoginUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kakaoLoginUsecaseHash();

  @$internal
  @override
  $ProviderElement<KakaoLoginUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KakaoLoginUsecase create(Ref ref) {
    return kakaoLoginUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KakaoLoginUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KakaoLoginUsecase>(value),
    );
  }
}

String _$kakaoLoginUsecaseHash() => r'a82c7990640eb6a4c0e5ee827c4b7f6e4cbb3d6c';
