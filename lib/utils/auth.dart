import 'package:flutter/material.dart';
import 'package:doal/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthClass {
  //initialize google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn(BuildContext context, String email) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Get the current user
        User? currentUser = auth.currentUser;

        if (currentUser != null) {
          // Attempt to link the Google credential to the current user
          try {
            await currentUser.linkWithCredential(credential);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'credential-already-in-use') {
              // The Google credential is already linked to another account
              // You may handle this case as needed
            } else {
              // Handle other exceptions
            }
          }
        }
      } else {
        // Handle sign-in error
      }
    } catch (e) {
      // Handle other exceptions
    }
  }
}
