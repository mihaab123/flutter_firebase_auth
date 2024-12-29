import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/utils/Styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CustomText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? styleP26,
    );
  }
}
