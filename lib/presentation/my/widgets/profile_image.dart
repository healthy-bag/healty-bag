import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        'https://picsum.photos/200',
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      ),
    );
  }
}
