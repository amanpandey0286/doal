import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doal/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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
      'time': _timeOfDay.hour,
      'date': _dateTime,
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

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
    return Material(
      color: Color(0xff29274F),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              Text(
                "New Work",
                style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    labelText: " Todo title ",
                    prefixIcon: Icon(Icons.add_task_outlined),
                    hintText: "Enter your to do title"),
              ),
              SizedBox(
                height: 5.0,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 10.0,
                endIndent: 10.0,
                color: Colors.deepOrange,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.date_range_rounded),
                    Text("Set Date",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 100.0,
                    ),
                    TextButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          _dateTime.day.toString(),
                          style:
                              TextStyle(color: Colors.white70, fontSize: 18.0),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.timer_sharp),
                    const Text("Set Time",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 100.0,
                    ),
                    TextButton(
                        onPressed: _showTimePicker,
                        child: Text(
                          _timeOfDay.format(context).toString(),
                          style:
                              TextStyle(color: Colors.white70, fontSize: 18.0),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 10.0,
                endIndent: 10.0,
                color: Colors.deepOrange,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Workspace",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(width: 1, color: Colors.white)),
                      elevation: MaterialStateProperty.all(0.0),
                      fixedSize: MaterialStateProperty.all(Size(150, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          "Study",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Icon(Icons.arrow_downward),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
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
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
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
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addtasktofirebase();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      fixedSize: MaterialStateProperty.all(
                        Size(120, 40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
