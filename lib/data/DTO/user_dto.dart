// 구글 및 카카오 로그인 시 사용자 정보를 담는 dto
class UserDTO {
  final String uid;
  final String nickname;
  final int followerCount;
  final int followingCount;
  final bool isFollowing;
  final int feedCount;
  final String profileUrl;

  UserDTO({
    required this.uid,
    required this.nickname,
    required this.followerCount,
    required this.followingCount,
    required this.isFollowing,
    required this.feedCount,
    required this.profileUrl,
  });
}
