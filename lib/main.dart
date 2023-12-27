import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/pages/to_do_add_page.dart';
import 'package:doal/pages/view_edit_todo.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
            return const HomePage();
          } else {
            return const SignUpPage(
              email: '',
            );
          }
        },
      ),
      theme: MyTheme.MyThemeData(),
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.signUpRoute: (context) => const SignUpPage(
              email: '',
            ),
        MyRoutes.signInRoute: (context) => const SignInPage(),
        MyRoutes.addtodo: (context) => const AddToDoWidget(),
        MyRoutes.viewtodo: (context) => const ViewToDoWidget(taskId: '',),
      },
    );
  }
}
