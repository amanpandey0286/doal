import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
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
                    // _username = value!;
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
                    Expanded(child: Container()),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      },
                      child: Text("Already a User?"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    // startauthentication();
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    fixedSize: MaterialStateProperty.all(
                      Size(120, 50),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ]),
            ),
          )
        ],
      )),
    ));
  }
}
