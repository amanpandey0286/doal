import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthClass {
  GoogleSignIn _googleSignIn = GoogleSignIn(
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

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          // If the user is successfully signed in, check if the Google account is linked to an existing user.
          bool isLinked = await isGoogleAccountLinked(email);

          if (isLinked) {
            // If the user exists and the Google account is linked, navigate them to the home page or the desired screen.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            // If the user exists but the Google account is not linked, let them link the account.
            // You can redirect them to a screen for account linking or handle it as per your requirement.
            // For now, I'll show a snackbar message as an example.
            final snackbar = SnackBar(
                content:
                    Text("Please link your Google account to this email."));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        } catch (e) {
          // If the Google sign-in fails, check if the user exists with the same email.
          // If not, create a new user account using the Google credentials.
          bool userExistsWithEmail = await doesUserExistWithEmail(email);
          if (!userExistsWithEmail) {
            await createUserWithGoogleCredential(email, credential);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            final snackbar = SnackBar(content: Text(e.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        }
      } else {
        final snackbar = SnackBar(content: Text("Not able to sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<bool> isGoogleAccountLinked(String email) async {
    // Implement the logic to check if the Google account is linked to an existing user.
    // You can do this by querying your Firestore/Realtime Database or using any other method.
    // Return true if the Google account is linked, false otherwise.

    // For now, let's assume the Google account is linked for any existing email for demonstration purposes.
    return true;
  }

  Future<bool> doesUserExistWithEmail(String email) async {
    // Implement the logic to check if a user with the given email exists.
    // You can do this by querying your Firestore/Realtime Database or using any other method.
    // Return true if the user exists, false otherwise.

    // For now, let's assume the user exists for any email for demonstration purposes.
    return true;
  }

  Future<void> createUserWithGoogleCredential(
      String email, AuthCredential credential) async {
    // Implement the logic to create a new user with the provided email and Google credentials.
    // You can store the user data in your Firestore/Realtime Database or any other method.

    // For now, let's assume the user is created successfully for any email for demonstration purposes.
  }
}
