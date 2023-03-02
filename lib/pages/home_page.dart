import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/widgets/todowidget.dart';
import 'package:flutter/material.dart';

import '../widgets/new_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff29274F),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF3E3A6D),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/ToDo');
          },
        ),
        drawer: NewDrawer(),
        appBar: AppBar(
          title: Text(
            "Today's To Do",
            style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [TodoWidget(), TodoWidget(), TodoWidget()],
          ),
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
