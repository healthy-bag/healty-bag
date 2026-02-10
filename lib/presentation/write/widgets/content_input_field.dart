import 'package:flutter/material.dart';

class ContentInputField extends StatelessWidget {
  const ContentInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 22),
      maxLines: 4,
      decoration: InputDecoration(
        hintText: '내용을 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
