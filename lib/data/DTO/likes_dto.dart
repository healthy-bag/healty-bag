class LikesDto {
  final String id;
  final String uid;
  final String nickname;
  final String feedId;

  LikesDto({
    required this.id,
    required this.uid,
    required this.nickname,
    required this.feedId,
  });

  factory LikesDto.fromJson(Map<String, dynamic> map) {
    return LikesDto(
      id: map['id'],
      uid: map['uid'],
      nickname: map['nickname'],
      feedId: map['feedId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'uid': uid, 'nickname': nickname, 'feedId': feedId};
  }
}
