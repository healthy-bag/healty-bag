class FollowDTO {
  final String uid;
  final String nickname;
  final String followId;

  FollowDTO({
    required this.uid,
    required this.nickname,
    required this.followId,
  });

  factory FollowDTO.fromMap(Map<String, dynamic> map) {
    return FollowDTO(
      uid: map['uid'],
      nickname: map['nickname'],
      followId: map['followId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'nickname': nickname, 'followId': followId};
  }
}
