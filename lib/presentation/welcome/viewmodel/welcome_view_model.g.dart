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
    extends $AsyncNotifierProvider<WelcomeViewModel, void> {
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

String _$welcomeViewModelHash() => r'43464e2a52fe26a4c4cacf8ff3070526a5bce176';

abstract class _$WelcomeViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
