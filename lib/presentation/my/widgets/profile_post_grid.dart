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
    print("feedCount : $feedCount");
    print("imageUrls : $imageUrls");
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.95,
      ),
      itemCount: feedCount,
      itemBuilder: (context, index) {
        return Image.network(imageUrls[index]);
      },
    );
  }
}
