// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_data_source_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(likeDataSource)
final likeDataSourceProvider = LikeDataSourceProvider._();

final class LikeDataSourceProvider
    extends $FunctionalProvider<LikeDataSource, LikeDataSource, LikeDataSource>
    with $Provider<LikeDataSource> {
  LikeDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeDataSourceHash();

  @$internal
  @override
  $ProviderElement<LikeDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LikeDataSource create(Ref ref) {
    return likeDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LikeDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LikeDataSource>(value),
    );
  }
}

String _$likeDataSourceHash() => r'587f8ea535f07ecb3b803dce5de2d8099b2f5b47';
