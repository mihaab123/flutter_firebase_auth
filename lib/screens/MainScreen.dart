import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/LoginScreen.dart';
import 'package:flutter_firebase_auth/utils/GoogleAuth.dart';
import 'package:flutter_firebase_auth/widgets/CustomButton.dart';
import 'package:flutter_firebase_auth/widgets/CustomText.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            CustomText(text: "BeomyTech"),
            CustomButton(
                child: CustomText(text: "Log Out"),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  await signOutFromGoogle();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                })
          ],
        ),
      ),
    ));
  }
}
