import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff29274F),
          brightness: Brightness.dark),
    );
  }
}
