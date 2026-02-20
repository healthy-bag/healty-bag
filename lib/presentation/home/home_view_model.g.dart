// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeViewModel)
final homeViewModelProvider = HomeViewModelProvider._();

final class HomeViewModelProvider
    extends $StreamNotifierProvider<HomeViewModel, List<FeedEntity>> {
  HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();
}

String _$homeViewModelHash() => r'e7c30278922c67af13241c9b8fab491ed4bbe2f8';

abstract class _$HomeViewModel extends $StreamNotifier<List<FeedEntity>> {
  Stream<List<FeedEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FeedEntity>>, List<FeedEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FeedEntity>>, List<FeedEntity>>,
              AsyncValue<List<FeedEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(feedComments)
final feedCommentsProvider = FeedCommentsFamily._();

final class FeedCommentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommentEntity>>,
          List<CommentEntity>,
          Stream<List<CommentEntity>>
        >
    with
        $FutureModifier<List<CommentEntity>>,
        $StreamProvider<List<CommentEntity>> {
  FeedCommentsProvider._({
    required FeedCommentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'feedCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedCommentsHash();

  @override
  String toString() {
    return r'feedCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CommentEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CommentEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return feedComments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedCommentsHash() => r'87839086718ed48945e23befc49fdc8c20000a45';

final class FeedCommentsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CommentEntity>>, String> {
  FeedCommentsFamily._()
    : super(
        retry: null,
        name: r'feedCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FeedCommentsProvider call(String feedId) =>
      FeedCommentsProvider._(argument: feedId, from: this);

  @override
  String toString() => r'feedCommentsProvider';
}
