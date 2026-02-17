// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data_source_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commentDataSource)
final commentDataSourceProvider = CommentDataSourceProvider._();

final class CommentDataSourceProvider
    extends
        $FunctionalProvider<
          CommentDataSource,
          CommentDataSource,
          CommentDataSource
        >
    with $Provider<CommentDataSource> {
  CommentDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentDataSourceHash();

  @$internal
  @override
  $ProviderElement<CommentDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommentDataSource create(Ref ref) {
    return commentDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentDataSource>(value),
    );
  }
}

String _$commentDataSourceHash() => r'4636c74452c0e9296c48c6edbb8ca2a5920dc0f1';
