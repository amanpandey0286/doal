import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff29274F),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: Column(
            children: [
              Text(
                "New Work",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    labelText: " Todo title ",
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
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Date",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "04-02-23",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Due",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "05-02-23",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Time",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Start",
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0xFFCACACA)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "04-02-23",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Due",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "05-02-23",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                ],
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
                        Text(
                          "Study",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
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
                  padding: const EdgeInsets.all(32.0),
                  child: Text("Enter your ToDo description"),
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
                      Navigator.pushNamed(context, '/Home');
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
