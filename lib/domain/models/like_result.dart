sealed class LikeResult {}

class IsLikeSuccess implements LikeResult {
  final bool isLiked;
  IsLikeSuccess({required this.isLiked});
}

class ToggleSuccess implements LikeResult {}

class LikeFailure implements LikeResult {
  final String message;
  LikeFailure({required this.message});
}
