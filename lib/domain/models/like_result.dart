sealed class LikeResult {}

class LikeSuccess<T> implements LikeResult {
  final T data;
  LikeSuccess({required this.data});
}

class LikeFailure implements LikeResult {
  final String message;
  LikeFailure({required this.message});
}
