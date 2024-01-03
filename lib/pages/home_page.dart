import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doal/pages/important_task_page.dart';
import 'package:doal/pages/today_task_page.dart';
import 'package:doal/pages/view_edit_todo.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:doal/utils/updateCheckValue.dart';
import 'package:doal/widgets/error_loader_widget.dart';
import 'package:doal/widgets/new_drawer.dart';
import 'package:doal/widgets/to_do_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = '1';
  int myIndex = 0;
  bool _isMounted = false;
  List<String> appBarTitles = [
    "Today's Tasks",
    "All Tasks",
    "Important Tasks",
  ];
  bool checkvalue = false;
  @override
  void initState() {
    _isMounted = true;

    getUid();
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      // Wait for the user to be fully authenticated
      await user.reload();
      final updatedUser = auth.currentUser;

      if (_isMounted && updatedUser != null) {
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
        title: Text(
          appBarTitles[myIndex],
          style: const TextStyle(
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: IndexedStack(index: myIndex, children: [
        TodayTasksPage(),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Todo')
              .doc(uid)
              .collection('mytasks')
              .orderBy('check')
              .orderBy('date')
              .orderBy('time')
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
              return ErrorLoaderWidget(
                errorText: 'No tasks available',
              );
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var task = docs[index].data();
                  var taskId =
                      docs[index].id; // Fetch the document ID as taskId
                  var dueDate = task['date']?.toString() ??
                      ''; // Handle null with default value
                  var dueTime = task['time']?.toString() ??
                      ''; // Handle null with default value
                  var taskTitle = task['title']?.toString() ??
                      ''; // Handle null with default value
                  bool remCheck = task['remCheck'];
                  bool impCheck = task['impCheck'];
                  bool doneCheck = task['check'];

                  return InkWell(
                    onTap: () {
                      if (taskId.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewToDoWidget(taskId: taskId),
                          ),
                        );
                      } else {
                        // Handle the case when taskId is empty
                        // For example, show an error message or log an error
                        Fluttertoast.showToast(msg: 'Can,t show');
                      }
                    },
                    child: ToDoWidget(
                      due_date: dueDate,
                      due_time: dueTime,
                      title: taskTitle,
                      check: doneCheck,
                      index: taskId,
                      onChange: onChange,
                      remCheck: remCheck,
                      impCheck: impCheck,
                    ),
                  );
                },
              );
            }
          },
        ),
        ImportantTasksPage(),
      ]),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.calendar_today),
          Icon(Icons.all_inbox),
          Icon(Icons.star),
        ],
        index: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        backgroundColor:
            MyTheme.MyThemeData().scaffoldBackgroundColor, //Color(0xff29274F),
        color: MyTheme.MyThemeData().primaryColor,
        animationDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  //to update checkvalue

  void onChange(String taskId) {
    setState(() {
      checkvalue = !checkvalue;
      EditOperations().updateCheckValue(taskId, checkvalue);
    });
  }
}
