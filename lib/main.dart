import 'package:doal/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/todo_page.dart';
import 'pallete.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SignUpPage(),
        '/SignIn': (context) => SignInPage(),
        '/Home': (context) => HomePage(),
        '/ToDo': (context) => ToDoPage(),
      },
    );
  }
}
