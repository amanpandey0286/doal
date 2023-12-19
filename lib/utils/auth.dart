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
      //pop up for google sign in and store value in variable
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        //to get crendential for auth.
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try {
          // ignore: unused_local_variable
          UserCredential? userCredential = await FirebaseAuth
              .instance.currentUser
              ?.linkWithCredential(credential);
          // The user can now sign in using any linked authentication provider.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'provider-already-linked') {
            // The provider has already been linked to the user.
            print("The provider has already been linked to the user.");
          } else if (e.code == 'invalid-credential') {
            // The provider's credential is not valid.
            print("The provider's credential is not valid.");
          } else if (e.code == 'credential-already-in-use') {
            // The account corresponding to the credential already exists, or is already linked to a Firebase User.
            print("The account corresponding to the credential already exists, "
                "or is already linked to a Firebase User.");
          } else {
            // Handle other exceptions
            print("Unknown error.");
          }
        }
      } else {
        const snackbar = SnackBar(content: Text("Not able to sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
