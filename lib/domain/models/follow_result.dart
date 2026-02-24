sealed class FollowResult {}

class FollowSuccess implements FollowResult {}

class FollowFailure implements FollowResult {
  final String message;
  const FollowFailure({required this.message});
}

class FetchFollowingUsersSuccess<T> implements FollowResult {
  final T data;
  const FetchFollowingUsersSuccess({required this.data});
}
