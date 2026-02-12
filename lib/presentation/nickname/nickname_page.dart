import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_bag/presentation/nickname/nickname_view_model.dart';
import 'package:healthy_bag/presentation/nickname/widgets/nickname_image_picker_area.dart';
import 'package:healthy_bag/presentation/nickname/widgets/start_button.dart';

class NicknamePage extends ConsumerStatefulWidget {
  final String uid;
  const NicknamePage({super.key, required this.uid});

  @override
  ConsumerState<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends ConsumerState<NicknamePage> {
  // 입력값을 제어하기 위한 컨트롤러
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nicknameViewModelProvider);
    final viewModel = ref.read(nicknameViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NicknameImagePickerArea(viewModel: viewModel, state: state),
              const SizedBox(height: 42),
              Text(
                "닉네임을 입력해주세요.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '영문 3자 이상 + 숫자 1자 이상 포함',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: (value) {
                  viewModel.setNickname(value);
                },
                maxLength: 12,
                decoration: InputDecoration(
                  // labelText: "닉네임",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: state.isValid
                        ? BorderSide(color: Colors.pinkAccent, width: 2)
                        : BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              StartButton(state: state),
            ],
          ),
        ),
      ),
    );
  }
}
