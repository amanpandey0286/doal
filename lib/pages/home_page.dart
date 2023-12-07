import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/widgets/to_do_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Today's To Do",
            style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            ToDoWidget(),
            ToDoWidget(),
            ToDoWidget(),
            ToDoWidget(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(Icons.calendar_view_day),
            Icon(Icons.all_inbox),
            Icon(Icons.home),
          ],
          backgroundColor: Color(0xff29274F),
          color: Color(0xFF3E3A6D),
        ));
  }
}
