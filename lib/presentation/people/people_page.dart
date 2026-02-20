import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  final String uid;
  const PeoplePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('People')),
      body: Center(child: Text('$uid의 피드')),
    );
  }
}
