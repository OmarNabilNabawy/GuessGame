import 'package:flutter/material.dart';

class WinView extends StatelessWidget {
  const WinView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'WIN',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
