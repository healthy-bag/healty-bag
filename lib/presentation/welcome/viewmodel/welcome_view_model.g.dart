// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WelcomeViewModel)
final welcomeViewModelProvider = WelcomeViewModelProvider._();

final class WelcomeViewModelProvider
    extends $AsyncNotifierProvider<WelcomeViewModel, AuthResult?> {
  WelcomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeViewModelHash();

  @$internal
  @override
  WelcomeViewModel create() => WelcomeViewModel();
}

String _$welcomeViewModelHash() => r'1ea590b768bad99d409c5e88e67796791cc2ecc1';

abstract class _$WelcomeViewModel extends $AsyncNotifier<AuthResult?> {
  FutureOr<AuthResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthResult?>, AuthResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthResult?>, AuthResult?>,
              AsyncValue<AuthResult?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
