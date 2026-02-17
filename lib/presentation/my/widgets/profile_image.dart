import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileUrl});
  final String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: profileUrl == null
          ? CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            )
          : Image.network(
              profileUrl!,
              fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
    );
  }
}
