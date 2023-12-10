import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignUpPage(
              email: '',
            );
          }
        },
      ),
      theme: MyTheme.MyThemeData(),
      routes: {
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.SignUpRoute: (context) => SignUpPage(
              email: '',
            ),
        MyRoutes.SignInRoute: (context) => SignInPage(),
      },
    );
  }
}
