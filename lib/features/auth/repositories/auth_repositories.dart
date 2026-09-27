import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositories {
  Future<UserCredential> googleLogin() async {
    // 1. login to google
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // 2. get google authentication
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // 3. create firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    // 4.login to firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
  }
}
