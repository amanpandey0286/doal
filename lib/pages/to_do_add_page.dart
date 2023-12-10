import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddToDoWidget extends StatefulWidget {
  const AddToDoWidget({super.key});

  @override
  State<AddToDoWidget> createState() => _AddToDoWidgetState();
}

class _AddToDoWidgetState extends State<AddToDoWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    var date = _dateTime;
    var time = _timeOfDay;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString()) //align according to this.
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': _timeOfDay.format(context),
      'date': _dateTime.microsecondsSinceEpoch,
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2040))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF9288E4),
                    Color(0xFF534EA7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  const Text(
                    "New Task",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        labelText: " Todo title ",
                        prefixIcon: const Icon(Icons.add_task_outlined),
                        hintText: "Enter your to do title"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.date_range_rounded),
                        const Text("Due Date",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 100.0,
                        ),
                        TextButton(
                            onPressed: _showDatePicker,
                            child: Text(
                              _dateTime.day.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.timer_sharp),
                        const Text("Set Time",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 100.0,
                        ),
                        TextButton(
                            onPressed: _showTimePicker,
                            child: Text(
                              _timeOfDay.format(context).toString(),
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 18.0),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF555294),
                            Color(0xFF3E3A6D),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.1, 0.9],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        minLines: 8,
                        maxLines: 8,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            labelText: " To Do Description ",
                            hintText: "Enter your to do description"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addtasktofirebase();
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      fixedSize: MaterialStateProperty.all(
                        const Size(120, 40),
                      ),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      )),
    );
  }
}
