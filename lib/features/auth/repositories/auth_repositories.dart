import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositories {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Facebook
  Future<UserCredential> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      throw Exception('Facebook login cancelled or failed');
    }

    final AccessToken accessToken = result.accessToken!;
    print(accessToken);

    final OAuthCredential credential = FacebookAuthProvider.credential(
      accessToken.tokenString,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Google
  Future<UserCredential> googleLogin() async {
    // 1. login to google
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();
    print('Email: ${googleUser.email}');

    // 2. get google authentication
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    print('ID Token: ${googleAuth.idToken != null}');

    // 3. create firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    // 4.login to firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    // for google logout
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();

    // for facebook logout
    await FacebookAuth.instance.logOut();
    await _firebaseAuth.signOut();
  }
}
