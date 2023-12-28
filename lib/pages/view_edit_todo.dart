import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ViewToDoWidget extends StatefulWidget {
  final String taskId;

  const ViewToDoWidget({Key? key, required this.taskId}) : super(key: key);

  @override
  State<ViewToDoWidget> createState() => _ViewToDoWidgetState();
}

class _ViewToDoWidgetState extends State<ViewToDoWidget> {
  TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  late bool _impCheck;
  late bool _remCheck;
  late TextEditingController _dateC;
  late TextEditingController _timeC;
  bool edit = false;
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _dateC = TextEditingController(); // Initialize _dateC
    _timeC = TextEditingController(); // Initialize _timeC
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Fetch the task document using the passed taskId
      DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .doc(widget.taskId) // Use the passed task ID
          .get();

      if (taskSnapshot.exists) {
        // Populate the controllers and variables with fetched data
        var data = taskSnapshot.data() as Map<String, dynamic>;
        setState(() {
          titleController = TextEditingController(text: data['title']);
          descriptionController =
              TextEditingController(text: data['description']);
          _dateC.text = data['date'] ?? '';
          _timeC.text = data['time'] ?? '';
          _impCheck = data['impCheck'] ?? false;
          _remCheck = data['remCheck'] ?? false;
          _dataFetched = true;
        });
      }
    }
  }

  Future<void> updateData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Fetch the task document using the passed taskId
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .doc(widget.taskId); // Use the passed task ID

      DocumentSnapshot taskSnapshot = await documentReference.get();

      if (taskSnapshot.exists) {
        // Populate the controllers and variables with fetched data
        var data = taskSnapshot.data() as Map<String, dynamic>;

        // Update the fields with new data (assumed from edited values)
        data['title'] = titleController.text;
        data['description'] = descriptionController.text;
        data['impCheck'] = _impCheck;
        data['remCheck'] = _remCheck;
        data['date'] = _dateC.text;
        data['time'] = _timeC.text;
        data['check'] = false;

        // Update the document with the modified data
        await documentReference.update(data);
        Fluttertoast.showToast(msg: 'Task Updated');
      }
    }
  }

  Future<void> deleteTask() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Reference the task document using the passed taskId
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .doc(widget.taskId); // Use the passed task ID

      DocumentSnapshot taskSnapshot = await documentReference.get();

      if (taskSnapshot.exists) {
        // Delete the document from Firestore
        await documentReference.delete();
        Fluttertoast.showToast(msg: 'Task Deleted');
      }
    }
  }

  ///Date
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);

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
        _timeC.text = "${time.hour}:${time.minute}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                children: [
                  Icon(
                    edit ? Icons.check : Icons.edit,
                    color: edit ? Colors.green : Colors.white,
                  ),
                  Text(
                    edit ? "Save" : "Edit",
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                edit = !edit;
                if (!edit) {
                  updateData();
                }
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              heroTag: "btn2",
              child: const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Column(
                  children: [
                    Icon(Icons.delete),
                    Text(
                      "Delete",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              onPressed: () {
                deleteTask();
                Navigator.pushNamed(context, MyRoutes.homeRoute);
              })
        ],
      ),
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
                  Text(
                    edit ? "Editing Task" : "Viewing Task",
                    style: const TextStyle(
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
                      enabled: edit,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              color: Colors.white30,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          labelText: " title ",
                          prefixIcon: const Icon(Icons.add_task_outlined),
                          hintText: " your to do title"),
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
                          onPressed:
                              edit ? () => displayDatePicker(context) : null,
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
                            onPressed:
                                edit ? () => displayTimePicker(context) : null,
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
                          child: IgnorePointer(
                            ignoring: !edit,
                            child: !_dataFetched
                                ? CircularProgressIndicator()
                                : LiteRollingSwitch(
                                    value: _impCheck,
                                    textOn: 'enabled',
                                    textOff: 'disabled',
                                    colorOn: Colors.greenAccent,
                                    colorOff: Colors.redAccent,
                                    iconOn: Icons.done,
                                    iconOff: Icons.close,
                                    textSize: 16.0,
                                    onChanged: edit
                                        ? (newValue) {
                                            setState(() {
                                              _impCheck = newValue;
                                            });
                                          }
                                        : (bool
                                            newValue) {}, // Empty function when 'edit' is false
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: edit
                                        ? () {
                                            setState(() {
                                              _impCheck = !_impCheck;
                                              print(
                                                  'impCheckerValue: $_impCheck');
                                            });
                                          }
                                        : () {}, // Empty function when 'edit' is false
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                    child: Row(
                      children: [
                        Icon(Icons.star_border_purple500_sharp),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text("Remainder",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        Transform.scale(
                          scale: 0.6,
                          child: IgnorePointer(
                            ignoring: !edit,
                            child: !_dataFetched
                                ? CircularProgressIndicator()
                                : LiteRollingSwitch(
                                    value: _remCheck,
                                    textOn: 'enabled',
                                    textOff: 'disabled',
                                    colorOn: Colors.greenAccent,
                                    colorOff: Colors.redAccent,
                                    iconOn: Icons.done,
                                    iconOff: Icons.close,
                                    textSize: 16.0,
                                    onChanged: edit
                                        ? (newValue) {
                                            setState(() {
                                              _remCheck = newValue;
                                            });
                                          }
                                        : (bool
                                            newValue) {}, // Empty function when 'edit' is false
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: edit
                                        ? () {
                                            setState(() {
                                              _remCheck = !_remCheck;
                                            });
                                          }
                                        : () {}, // Empty function when 'edit' is false
                                  ),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextFormField(
                          maxLines: null,
                          controller: descriptionController,
                          enabled: edit,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: " To Do Description ",
                              hintText: " your to do description"),
                        ),
                      ),
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
