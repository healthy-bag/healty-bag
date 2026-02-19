// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_data_source_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedDataSource)
final feedDataSourceProvider = FeedDataSourceProvider._();

final class FeedDataSourceProvider
    extends $FunctionalProvider<FeedDataSource, FeedDataSource, FeedDataSource>
    with $Provider<FeedDataSource> {
  FeedDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedDataSourceHash();

  @$internal
  @override
  $ProviderElement<FeedDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedDataSource create(Ref ref) {
    return feedDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedDataSource>(value),
    );
  }
}

String _$feedDataSourceHash() => r'8ed2df4a340fe945f5852a276636706ddc02483e';
