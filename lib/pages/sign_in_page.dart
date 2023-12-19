import 'package:doal/utils/auth.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/widgets/common_widget.dart';
import 'package:doal/widgets/google_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool circular = false;

  GoogleAuthClass googleAuthClass = GoogleAuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const common_widget(),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  child: Form(
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () async {
                              await googleAuthClass.googleSignIn(
                                  context, _emailController.toString());
                            },
                            child: const GoogleButton()),
                        const Text(
                          "OR",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(
                                  color: Colors.white30,
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              labelText: "Email",
                              hintText: "Enter your Email"),
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Incorrect Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(
                                  color: Colors.white24,
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              labelText: "Password",
                              hintText: "Enter your Password"),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect Password';
                            }
                            return null;
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
                              child: const Text(
                                "Forgot Password?",
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.signUpRoute);
                          },
                          child: const Text(
                            "Back to Sign up >",
                            style: TextStyle(
                              fontSize: 16.0,
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
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              firebase_auth.UserCredential userCredential =
                                  await firebaseAuth.signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _pwdController.text);
                              print(userCredential.user!.email);
                              setState(() {
                                circular = false;
                              });
                              Navigator.pushNamed(context, MyRoutes.homeRoute);
                            } catch (e) {
                              final snackbar =
                                  SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              setState(() {
                                circular = false;
                              });
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            fixedSize: MaterialStateProperty.all(
                              const Size(120, 50),
                            ),
                          ),
                          child: circular
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
