// https://budge-tracker-app.firebaseapp.com/__/auth/handler

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signInWithFacebook() async {
  final LoginResult result = await FacebookAuth.instance.login();

  if (result.status == LoginStatus.success) {
    final AccessToken accessToken = result.accessToken!;
    final OAuthCredential credential =
        FacebookAuthProvider.credential(accessToken.tokenString);

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  } else if (result.status == LoginStatus.cancelled) {
    print('Login cancelled by the user.');
  } else {
    print('Login error: ${result.message}');
  }
  return null;
}
