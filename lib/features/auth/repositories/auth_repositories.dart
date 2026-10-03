import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositories {
  final FirebaseAuth auth;

  AuthRepositories(this.auth);

  Future<UserCredential> signUp(
    String name,
    String email,
    String password,
  ) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = userCredential.user!;

    await user.updateDisplayName(name);

    await user.reload();

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'fullName': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });

    return userCredential;
  }

  // Email Login
  Future<UserCredential> signIn(String email, String password) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Facebook Login

  Future<UserCredential> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      throw Exception('Facebook login cancelled or failed');
    }

    final AccessToken? accessToken = result.accessToken;

    if (accessToken == null) {
      throw Exception('Facebook access token is null');
    }

    final OAuthCredential credential = FacebookAuthProvider.credential(
      accessToken.tokenString,
    );

    return await auth.signInWithCredential(credential);
  }

  // Google Login
  Future<UserCredential> googleLogin() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    print('Google Email: ${googleUser.email}');

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    print('ID Token: ${googleAuth.idToken != null}');

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  // Logout
  Future<void> logout() async {
    await auth.signOut();

    await GoogleSignIn.instance.signOut();

    await FacebookAuth.instance.logOut();
  }
}
