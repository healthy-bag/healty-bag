import 'package:flutter/material.dart';
import 'package:healthy_bag/presentation/home/home_page.dart';
import 'package:healthy_bag/presentation/nickname/nickname_view_model.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key, required this.state});

  final NicknameState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isValid
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: state.isValid ? Colors.pinkAccent : Colors.white10,
          foregroundColor: state.isValid ? Colors.white : Colors.white38,
          elevation: state.isValid ? 4 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text("시작하기"),
      ),
    );
  }
}
