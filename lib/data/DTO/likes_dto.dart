class LikesDto {
  final String uid;
  final String nickname;
  final String feedId;

  LikesDto({required this.uid, required this.nickname, required this.feedId});

  factory LikesDto.fromMap(Map<String, dynamic> map) {
    return LikesDto(
      uid: map['uid'],
      nickname: map['nickname'],
      feedId: map['feedId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'nickname': nickname, 'feedId': feedId};
  }
}
