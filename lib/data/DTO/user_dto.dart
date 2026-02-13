// 구글 및 카카오 로그인 시 사용자 정보를 담는 dto
class UserDTO {
  final String uid;
  final String nickname;
  final int followerCount;
  final int followingCount;
  final int feedCount;
  final String profileUrl;

  UserDTO({
    required this.uid,
    required this.nickname,
    required this.followerCount,
    required this.followingCount,
    required this.feedCount,
    required this.profileUrl,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      feedCount: json['feedCount'] as int,
      profileUrl: json['profileUrl'] as String,
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

  UserDTO copyWith({
    String? uid,
    String? nickname,
    int? followerCount,
    int? followingCount,
    int? feedCount,
    String? profileUrl,
  }) {
    return UserDTO(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      feedCount: feedCount ?? this.feedCount,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }
}
