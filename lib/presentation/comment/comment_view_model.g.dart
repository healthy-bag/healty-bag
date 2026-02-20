// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommentViewModel)
final commentViewModelProvider = CommentViewModelProvider._();

final class CommentViewModelProvider
    extends $NotifierProvider<CommentViewModel, CommentState> {
  CommentViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentViewModelHash();

  @$internal
  @override
  CommentViewModel create() => CommentViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentState>(value),
    );
  }
}

String _$commentViewModelHash() => r'2acb0575434bc0077b661bcf9c37865dde4c0f4c';

abstract class _$CommentViewModel extends $Notifier<CommentState> {
  CommentState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CommentState, CommentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CommentState, CommentState>,
              CommentState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
