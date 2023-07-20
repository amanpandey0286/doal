import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/pages/todo_page.dart';
import 'package:doal/widgets/todowidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/new_drawer.dart';

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
        backgroundColor: Color(0xff29274F),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF3E3A6D),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ToDoPage()),
            );
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
          child: StreamBuilder<QuerySnapshot>(
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
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: 80.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF4C465),
                              Color(0xFFC63956),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.9],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.task_alt_outlined,
                                  size: 40.0,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    docs[index]['title'],
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Workspace",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    docs[index]['time'].toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  // Text(
                                  //   docs[index]['date'].toString(),
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }
            }),
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
