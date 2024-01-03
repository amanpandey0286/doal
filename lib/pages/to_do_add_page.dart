import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/utils/myalarm.dart';
import 'package:doal/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';

class AddToDoWidget extends StatefulWidget {
  const AddToDoWidget({super.key});

  @override
  State<AddToDoWidget> createState() => _AddToDoWidgetState();
}

class _AddToDoWidgetState extends State<AddToDoWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool impCheck = false;
  bool remCheck = false;
  final _dateC = TextEditingController();
  final _timeC = TextEditingController();

  Future<void> addTaskToFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      // String taskId = generateTaskId();

      var docRef = await FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .add({
        'title': titleController.text,
        'description': descriptionController.text,
        'time': _timeC.text,
        'date': _dateC.text,
        'impCheck': impCheck,
        'remCheck': remCheck,
        'check': false,
      });

      var taskId = docRef.id;

      Fluttertoast.showToast(msg: 'Data Added');
      if (remCheck) {
        // Fetch the title and time
        int notficationId = MyNotification().getNotificationId(taskId);
        String title = titleController.text;
        String time = _timeC.text;
        String date = _dateC.text;

        // Schedule notification
        MyNotification().showNotification(notficationId, title, time, date);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize _dateC with the current date
    _dateC.text = DateTime.now().toLocal().toString().split(" ")[0];

    // Initialize _timeC with the current time
    final currentTime = TimeOfDay.now();
    _timeC.text = '${currentTime.hour}:${currentTime.minute}';
  }

  ///Date
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2050);

  ///Time
  TimeOfDay timeOfDay = TimeOfDay.now();

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        _dateC.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _timeC.text =
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Lottie.asset('assets/images/add_task.json'),
          ),
          Expanded(
            child: Container(
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
                child: SingleChildScrollView(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Colors.white60,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            labelText: " Task title ",
                            hintText: "Enter your task title"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_rounded),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Set Date",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Expanded(child: Container()),
                          TextButton(
                            onPressed: () => displayDatePicker(context),
                            child: Text(
                              _dateC.text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.timer_sharp),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Set Time",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () => displayTimePicker(context),
                              child: Text(
                                _timeC.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: Row(
                        children: [
                          Icon(Icons.star_border_purple500_sharp),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Important",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Expanded(child: Container()),
                          Transform.scale(
                            scale: 0.6,
                            child: LiteRollingSwitch(
                              value: false,
                              textOn: 'enabled',
                              textOff: 'disabled',
                              colorOn: Colors.greenAccent,
                              colorOff: Colors.redAccent,
                              iconOn: Icons.done,
                              iconOff: Icons.close,
                              textSize: 16.0,
                              onChanged: ((p0) {}),
                              onDoubleTap: () {},
                              onSwipe: () {},
                              onTap: () {
                                impCheck = !impCheck;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                      child: Row(
                        children: [
                          const Icon(Icons.alarm_on_outlined),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Remainder",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Expanded(child: Container()),
                          Transform.scale(
                            scale: 0.6,
                            child: LiteRollingSwitch(
                              value: false,
                              textOn: 'enabled',
                              textOff: 'disabled',
                              colorOn: Colors.greenAccent,
                              colorOff: Colors.redAccent,
                              iconOn: Icons.done,
                              iconOff: Icons.close,
                              textSize: 16.0,
                              onChanged: ((p0) {}),
                              onDoubleTap: () {},
                              onSwipe: () {},
                              onTap: () {
                                remCheck = !remCheck;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150.0,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: TextFormField(
                            maxLines: null,
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: " Task Description ",
                                hintText: "Enter your Task description"),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTaskToFirebase();
                        Navigator.pop(context);
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
              ),
            ),
          )
        ],
      )),
    );
  }
}
