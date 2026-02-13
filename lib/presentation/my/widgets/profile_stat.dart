import 'package:flutter/material.dart';

class ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  const ProfileStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.black)),
        SizedBox(height: 12),
        Text(value, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
