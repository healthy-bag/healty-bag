import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/data/DTO/comments_dto.dart';

// DTO에서 Entity로 변환하는 테스트 확인
void main (){
  test('DTO가 Entity로 정확하게 변환하는 확인 테스트', (){
    // 가짜 DTO 생성
    final dto = CommentsDTO(
      id: '1', 
      uid: 'user123', 
      feedId: 'feed456', 
      nickname: 'jin12', 
      comment: '오운완', 
      createdAt: '2026-02-12T15:08:46.000',
      );

    // dto를 entity로 변환
    final entity = dto.toEntity();

    // 값이 일치하는지 확인
    expect(entity.nickname, 'jin12');
    expect(entity.content, '오운완');
    expect(entity.timeAgo, isA<DateTime>());
    expect(entity.isLiked, false);
    expect(entity.likeCount, 0);
  });
}