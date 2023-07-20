import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  startauthentication() {
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
          email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff29274F),
      child: SafeArea(
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
                        SizedBox(
                          height: 40.0,
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
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: Text(
                            "Back to Sign up >",
                            style: TextStyle(fontSize: 15.0),
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
                          height: 30.0,
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
