import 'package:flutter/material.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({super.key, required this.feedCount});
  final int feedCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.95,
      ),
      itemCount: feedCount,
      itemBuilder: (context, index) {
        return SizedBox.expand();
      },
    );
  }
}
