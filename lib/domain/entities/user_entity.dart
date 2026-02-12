class UserEntity {
  final String uid;
  final String nickname;
  final int followerCount;
  final int followingCount;
  final int feedCount;
  final String profileUrl;

  UserEntity({
    required this.uid,
    required this.nickname,
    required this.followerCount,
    required this.followingCount,
    required this.feedCount,
    required this.profileUrl,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      uid: json['uid'],
      nickname: json['nickname'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      feedCount: json['feedCount'],
      profileUrl: json['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'followerCount': followerCount,
      'followingCount': followingCount,
      'feedCount': feedCount,
      'profileUrl': profileUrl,
    };
  }
}
