import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/utils/EmailAuth.dart';
import 'package:flutter_firebase_auth/utils/ShowErrorMessage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isCanUseLocalAuth() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<UserCredential?> authenticateWithBiometrics(context) async {
    bool isAuthenticated = false;
    UserCredential? credential;
    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      if (isAuthenticated) {
        credential = await emailSignIn(
            "test@gmail.com", "Qwerty12345", context); // TODO test data
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        showErrorMessage(context, "Bigometrics is not available");
      } else if (e.code == auth_error.passcodeNotSet) {
        showErrorMessage(context, "Bigometrics passcode is not set");
      } else if (e.code == auth_error.notEnrolled) {
        showErrorMessage(context, "Bigometrics is not enrolled");
      } else if (e.code == auth_error.lockedOut) {
        showErrorMessage(context, "Bigometrics is locked out");
      } else {
        showErrorMessage(context, e.message);
      }
    }
    return credential;
  }
}
