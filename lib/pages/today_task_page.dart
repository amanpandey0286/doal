import 'package:doal/pages/view_edit_todo.dart';
import 'package:doal/utils/updateCheckValue.dart';
import 'package:doal/widgets/error_loader_widget.dart';
import 'package:doal/widgets/to_do_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TodayTasksPage extends StatefulWidget {
  @override
  _TodayTasksPageState createState() => _TodayTasksPageState();
}

class _TodayTasksPageState extends State<TodayTasksPage> {
  bool checkvalue = false;
  Stream<QuerySnapshot> fetchTodayTasksStream() {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user != null) {
    String uid = user.uid;

    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);

    return FirebaseFirestore.instance
        .collection('Todo')
        .doc(uid)
        .collection('mytasks')
        .where('date', isEqualTo: formattedDate)
        .orderBy('check') // Sort based on the 'check' field (ascending order)
        .orderBy('time')
        .snapshots();
  }

  return Stream.empty(); // Return empty stream if user is null or no tasks found
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: fetchTodayTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return ErrorLoaderWidget(
              errorText: 'No tasks for today',
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var task = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var taskId =
                    snapshot.data!.docs[index].id; // Fetch the document ID as taskId
                var dueDate = task['date']?.toString() ??
                    ''; // Handle null with default value
                var dueTime = task['time']?.toString() ??
                    ''; // Handle null with default value
                var taskTitle = task['title']?.toString() ??
                    ''; // Handle null with default value
                bool remCheck = task['remCheck'];
                bool impCheck = task['impCheck'];
                bool doneCheck = task['check'];
                // Customize UI for each task
                return InkWell(
                  onTap: () {
                    if (taskId.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewToDoWidget(taskId: taskId),
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
