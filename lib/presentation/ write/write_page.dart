import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 추가', style: TextStyle(fontSize: 24)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              '확인',
              style: TextStyle(fontSize: 18, color: Colors.pink),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              width: double.infinity,
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.add_rounded,
                    size: 200,
                    weight: 300,
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    'new',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 22),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            TextField(
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                hintText: '#태그를 추가하세요',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
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
            ),
          ],
        ),
      ),
    );
  }
}
