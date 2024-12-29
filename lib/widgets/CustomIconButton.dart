import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final Function() onPressed;
  const CustomIconButton(
      {super.key, required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        iconPath,
        height: 28,
      ),
      onPressed: onPressed,
    );
  }
}
