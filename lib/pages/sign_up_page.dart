import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/widgets/common_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required String email});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  var _username = '';
  var _email = '';
  var _password = '';

  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = authResult.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'username': username, 'email': email});
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          common_widget(),
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
                  topRight: Radius.circular(60.0)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        labelText: "Name",
                        hintText: "Enter your name"),
                    keyboardType: TextInputType.emailAddress,
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Incorrect Username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
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
                      Expanded(child: Container()),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.signInRoute);
                        },
                        child: const Text(
                          "Already a User?",
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors
                                    .black54, // Choose the color of the shadow
                                blurRadius:
                                    2.0, // Adjust the blur radius for the shadow effect
                                offset: Offset(2.0,
                                    2.0), // Set the horizontal and vertical offset for the shadow
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      startauthentication();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      fixedSize: MaterialStateProperty.all(
                        Size(120, 50),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ]),
              ),
            ),
          )
        ],
      )),
    ));
  }
}
