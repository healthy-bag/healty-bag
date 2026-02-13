import 'package:flutter/material.dart';

class TagInputField extends StatelessWidget {
  const TagInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 22),
      decoration: InputDecoration(
        hintText: '#태그를 추가하세요',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
