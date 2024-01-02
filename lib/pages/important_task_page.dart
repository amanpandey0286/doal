import 'package:doal/pages/view_edit_todo.dart';

import 'package:doal/utils/updateCheckValue.dart';
import 'package:doal/widgets/error_loader_widget.dart';
import 'package:doal/widgets/to_do_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ImportantTasksPage extends StatefulWidget {
  const ImportantTasksPage({super.key});

  @override
  State<ImportantTasksPage> createState() => _ImportantTasksPageState();
}

class _ImportantTasksPageState extends State<ImportantTasksPage> {
  bool checkvalue = false;

  Stream<List<DocumentSnapshot>> fetchImportantTasksStream() async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      yield* FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .where('impCheck', isEqualTo: true)
          .orderBy('check')
          .orderBy('date')
          .orderBy('time')
          .snapshots()
          .map((snapshot) => snapshot.docs);
    }
    yield []; // Return empty list if user is null or no tasks found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: fetchImportantTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return ErrorLoaderWidget(
              errorText: 'No important tasks available',
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var task = snapshot.data![index].data() as Map<String, dynamic>;
                var taskId =
                    snapshot.data![index].id; // Fetch the document ID as taskId
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
