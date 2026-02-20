// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_image_usecase_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveImageUsecase)
final saveImageUsecaseProvider = SaveImageUsecaseProvider._();

final class SaveImageUsecaseProvider
    extends
        $FunctionalProvider<
          SaveImageUsecase,
          SaveImageUsecase,
          SaveImageUsecase
        >
    with $Provider<SaveImageUsecase> {
  SaveImageUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveImageUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveImageUsecaseHash();

  @$internal
  @override
  $ProviderElement<SaveImageUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveImageUsecase create(Ref ref) {
    return saveImageUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveImageUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveImageUsecase>(value),
    );
  }
}

String _$saveImageUsecaseHash() => r'164955a51ea9133053c7d9de545b4ee64eb48d96';
