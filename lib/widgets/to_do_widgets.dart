import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "ToDo title",
                    style: TextStyle(
                      fontSize: 20.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Start Date",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "Due Date",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}