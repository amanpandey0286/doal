import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/widgets/card_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/google_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  GoogleAuthClass googleAuthClass = GoogleAuthClass();

  void startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password);
    }
  }

  submitform(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;

    try {
      authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If sign-in with email and password is successful, navigate to the home page or the desired screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // If sign-in with email and password fails, show an error message and let GoogleAuthClass handle Google sign-in.
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return; // Return here to prevent the Google sign-in from being triggered if email-password sign-in failed.
    }

    // If sign-in was successful or account already linked, navigate to the home page.
    if (authResult.user != null ||
        await googleAuthClass.isGoogleAccountLinked(email)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // If the user signed in with email but hasn't linked the Google account, let them link the account.
      googleAuthClass.googleSignIn(context, email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29274F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Doal",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 55.0,
                  ),
                ),
              ),
              Container(
                child: Image.asset("assets/images/login_anim.gif"),
                height: 250.0,
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF9288E4),
                        Color(0xFF534EA7),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                            onTap: () async {
                              await googleAuthClass.googleSignIn(
                                  context, _email);
                            },
                            child: CardButton()),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              labelText: "Email",
                              hintText: "Enter your Email"),
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Incorrect Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              labelText: "Password",
                              hintText: "Enter your Password"),
                          obscureText: true,
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect Password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 100.0,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("Forgot Password?"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage(
                                        email: '',
                                      )),
                            );
                          },
                          child: Text(
                            "Back to Sign up >",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            startauthentication();
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(StadiumBorder()),
                            fixedSize: MaterialStateProperty.all(
                              Size(120, 50),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
