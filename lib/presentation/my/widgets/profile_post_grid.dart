import 'package:flutter/material.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({
    super.key,
    required this.feedCount,
    required this.imageUrls,
  });
  final int feedCount;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const Center(child: Text('아직 등록된 게시물이 없습니다.'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.95,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            print('long press');
          },
          child: Image.network(
            imageUrls[index],
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
