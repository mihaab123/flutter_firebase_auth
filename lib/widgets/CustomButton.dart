import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const CustomButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
