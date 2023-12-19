import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:doal/widgets/new_drawer.dart';
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
    getUid();
    super.initState();
  }

  Future<void> getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      // Wait for the user to be fully authenticated
      await user.reload();
      final updatedUser = auth.currentUser;

      if (updatedUser != null) {
        setState(() {
          uid = updatedUser.uid;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NewDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.MyThemeData().primaryColor,
        child: const Icon(Icons.add),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No tasks available'),
            );
          } else {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var task = docs[index].data();
                var dueDate = task['date']?.toString() ??
                    ''; // Handle null with default value
                var dueTime = task['time']?.toString() ??
                    ''; // Handle null with default value
                var taskTitle = task['title']?.toString() ??
                    ''; // Handle null with default value
                return ToDoWidget(
                  due_date: dueDate,
                  due_time: dueTime,
                  title: taskTitle,
                  check: false,
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
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
