import 'package:doal/utils/routes.dart';
import 'package:doal/widgets/common_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required String email});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance; // objext of firebase auth
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool circular = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CommonWidget(),
          Expanded(
            child: Container(
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
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(children: [
                      TextFormField(
                        controller: _nameController,
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
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
                      Container(
                        child: TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Colors.white30,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelText: "Password",
                            hintText: "Enter your Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _isObscure,
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.signInRoute);
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
                        onPressed: () async {
                          setState(() {
                            circular = true;
                          });
                          try {
                            firebase_auth.UserCredential userCredential =
                                await firebaseAuth
                                    .createUserWithEmailAndPassword(
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
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          fixedSize: MaterialStateProperty.all(
                            const Size(120, 50),
                          ),
                        ),
                        child: circular
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
