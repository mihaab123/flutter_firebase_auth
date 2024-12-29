import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/utils/Styles.dart';
import 'package:toast/toast.dart';

void showErrorMessage(context, text) {
  ToastContext().init(context);
  Toast.show(text,
      duration: Toast.lengthLong,
      gravity: Toast.top,
      backgroundColor: Colors.white,
      textStyle: styleP16.copyWith(color: Colors.red),
      border: Border.all(color: Colors.red, width: 2));
}
