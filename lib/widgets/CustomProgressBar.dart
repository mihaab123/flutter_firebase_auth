import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
  }
}
