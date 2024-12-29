import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/utils/Styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? hint;

  final TextInputType inputType;
  final List<TextInputFormatter>? formatters;
  final Function(String q)? onChanged;
  final Function(String q)? onSubmit;
  final Function()? onComplete;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    required this.inputType,
    this.formatters,
    this.onChanged,
    this.onSubmit,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: styleP16.copyWith(
          color: Colors.black,
        ),
        keyboardType: inputType,
        controller: controller,
        inputFormatters: formatters ?? [],
        onSubmitted: onSubmit,
        onChanged: onChanged,
        onEditingComplete: onComplete,
        cursorColor: Colors.grey,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: hint,
            labelText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            hintStyle: styleP16.copyWith(color: Colors.grey.withOpacity(.5)),
            labelStyle: styleP16.copyWith(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey))));
  }
}
