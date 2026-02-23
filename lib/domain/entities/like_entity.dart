class LikeEntity {
  final String id;
  final String uid;
  final String nickname;
  final String feedId;

  LikeEntity({
    required this.id,
    required this.uid,
    required this.nickname,
    required this.feedId,
  });

  factory LikeEntity.fromJson(Map<String, dynamic> map) {
    return LikeEntity(
      id: map['id'],
      uid: map['uid'],
      nickname: map['nickname'],
      feedId: map['feedId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'uid': uid, 'nickname': nickname, 'feedId': feedId};
  }

  LikeEntity copyWith({
    String? id,
    String? uid,
    String? nickname,
    String? feedId,
  }) {
    return LikeEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      feedId: feedId ?? this.feedId,
    );
  }
}
