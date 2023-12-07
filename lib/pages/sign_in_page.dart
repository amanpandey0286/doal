import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/widgets/common_widget.dart';
import 'package:doal/widgets/google_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              common_widget(),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: [
                      GoogleButton(),
                      Text(
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
                          // _email = value!;
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
                          // _password = value!;
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
                                    // email: '',
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
                          // startauthentication();
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
                        height: 10.0,
                      )
                    ],
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
