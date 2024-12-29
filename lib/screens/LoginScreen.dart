import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/MainScreen.dart';
import 'package:flutter_firebase_auth/utils/EmailAuth.dart';
import 'package:flutter_firebase_auth/utils/FacebookAuth.dart';
import 'package:flutter_firebase_auth/utils/GoogleAuth.dart';
import 'package:flutter_firebase_auth/utils/LocalAuth.dart';
import 'package:flutter_firebase_auth/utils/Styles.dart';
import 'package:flutter_firebase_auth/widgets/CustomButton.dart';
import 'package:flutter_firebase_auth/widgets/CustomIconButton.dart';
import 'package:flutter_firebase_auth/widgets/CustomProgressBar.dart';
import 'package:flutter_firebase_auth/widgets/CustomText.dart';
import 'package:flutter_firebase_auth/widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;
  bool isLoaging = false;
  bool isBiometricsAvailable = false;

  @override
  void initState() {
    checkBiometrics();
    super.initState();
  }

  void checkBiometrics() async {
    isBiometricsAvailable = await LocalAuth().isCanUseLocalAuth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Log In"),
                  CustomTextField(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    hint: "Email",
                  ),
                  CustomTextField(
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    hint: "Password",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: CustomButton(
                        child: isLoaging
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomProgressBar(),
                              )
                            : CustomText(
                                text: "Log In with Email",
                                style: styleP16,
                              ),
                        onPressed: () async {
                          setState(() {
                            isLoaging = true;
                          });
                          userCredential = await emailSignIn(
                              emailController.text,
                              passwordController.text,
                              context);
                          await userCheck(userCredential);
                        }),
                  ),
                  CustomText(
                    text: "or",
                    style: styleP16,
                  ),
                  Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        iconPath: "assets/images/google-icon.png",
                        onPressed: () async {
                          userCredential = await signInWithGoogle(context);
                          await userCheck(userCredential);
                        },
                      ),
                      CustomIconButton(
                        iconPath: "assets/images/facebook-icon.png",
                        onPressed: () async {
                          userCredential = await signInWithFacebook();
                          await userCheck(userCredential);
                        },
                      ),
                      isBiometricsAvailable
                          ? CustomIconButton(
                              iconPath: "assets/images/fingerprint-icon.png",
                              onPressed: () async {
                                userCredential = await LocalAuth()
                                    .authenticateWithBiometrics(context);

                                await userCheck(userCredential);
                              },
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userCheck(userCredential) async {
    if (userCredential != null) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      setState(() {
        isLoaging = false;
      });
    }
  }
}
