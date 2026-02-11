
import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/widgets/home/home_page.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({super.key});

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  // 입력값을 제어하기 위한 컨트롤러
  final TextEditingController _controller = TextEditingController();

  // 유효성 검사 결과 (영문 숫자 조합 3글자)
  bool get _isValid {
    final text = _controller.text;
    // 영문자(대소문자) 몇개 들어있는지 확인
    int letterCount = text.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    // 숫자 포함되어 있는지 확인
    bool hasNumber = text.contains(RegExp(r'[0-9]'));
    // 조건 : 영문 3개 이상, 숫자 1개 이상
    return letterCount >= 3 && hasNumber;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("닉네임을 입력해주세요.", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, fontWeight: FontWeight.bold,
                ),
                ),
              SizedBox(height: 5),
              Text('영문 3자 이상 + 숫자 1자 이상 포함',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: (value) => setState(() {}),
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: "닉네임",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: _isValid ? BorderSide(color: Colors.pinkAccent, width: 2) : BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isValid ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isValid ? Colors.pinkAccent : Colors.white10,
                    foregroundColor: _isValid ? Colors.white : Colors.white38,
                    elevation: _isValid ? 4 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                child: Text("시작하기"),
              ),
          )]
          ),
        ),
      ),
    );
  }
}
