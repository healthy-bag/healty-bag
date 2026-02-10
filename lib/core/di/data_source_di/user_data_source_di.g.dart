// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_source_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userDataSource)
final userDataSourceProvider = UserDataSourceProvider._();

final class UserDataSourceProvider
    extends $FunctionalProvider<UserDataSource, UserDataSource, UserDataSource>
    with $Provider<UserDataSource> {
  UserDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserDataSource create(Ref ref) {
    return userDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserDataSource>(value),
    );
  }
}

String _$userDataSourceHash() => r'5c3e0eafa85d485d0f21a98d68f092c72ea28ff5';
