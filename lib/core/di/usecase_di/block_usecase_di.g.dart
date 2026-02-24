// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_usecase_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(blockUsecase)
final blockUsecaseProvider = BlockUsecaseProvider._();

final class BlockUsecaseProvider
    extends $FunctionalProvider<BlockUsecase, BlockUsecase, BlockUsecase>
    with $Provider<BlockUsecase> {
  BlockUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockUsecaseHash();

  @$internal
  @override
  $ProviderElement<BlockUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BlockUsecase create(Ref ref) {
    return blockUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlockUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlockUsecase>(value),
    );
  }
}

String _$blockUsecaseHash() => r'1815493228c366459aef062222f6722709330bb6';
