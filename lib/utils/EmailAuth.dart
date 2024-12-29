import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/utils/ShowErrorMessage.dart';

Future<UserCredential?> emailSignIn(emailAddress, password, context) async {
  UserCredential? credential;
  try {
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // showErrorMessage(context, 'No user found for that email.');
      credential = await emailSignOut(emailAddress, password, context);
    } else if (e.code == 'wrong-password') {
      showErrorMessage(context, 'Wrong password provided for that user.');
    } else if (e.code == 'invalid-credential') {
      // showErrorMessage(context, 'No user found for that email.');
      credential = await emailSignOut(emailAddress, password, context);
    } else {
      showErrorMessage(context, e.message);
    }
  }
  return credential;
}

Future<UserCredential?> emailSignOut(emailAddress, password, context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showErrorMessage(context, 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      showErrorMessage(context, 'The account already exists for that email.');
    } else {
      showErrorMessage(context, e.message);
    }
    return null;
  } catch (e) {
    showErrorMessage(context, e.toString());
    return null;
  }
}
