import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:doal/widgets/to_do_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = '1';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.MyThemeData().primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.addtodo);
        },
      ),
      appBar: AppBar(
        title: const Text(
          "Today's To Do",
          style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: ((context, index) {
                var date = (docs[index]['date']);
                return ToDoWidget(
                  due_date: docs[index]['date'].toString(),
                  due_time: docs[index]['time'].toString(),
                  title: docs[index]['title'],
                );
              }),
            );
          }
        }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.calendar_view_day),
          Icon(Icons.all_inbox),
          Icon(Icons.home),
        ],
        backgroundColor:
            MyTheme.MyThemeData().scaffoldBackgroundColor, //Color(0xff29274F),
        color: MyTheme.MyThemeData().primaryColor,
      ),
    );
  }
}
