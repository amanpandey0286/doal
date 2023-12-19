import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoWidget extends StatelessWidget {
  ToDoWidget(
      {super.key, required this.due_date,
      required this.due_time,
      required this.title,
      required this.check});
  var due_date = '';
  var due_time = '';
  var title = '';
  var workspace = '';
  final bool check;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80.0,
        decoration: const BoxDecoration(
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
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color(0xFFC63956);
                        }
                        return const Color(0xFFC63956);
                      }),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onChanged: (bool? value) {},
                      value: false,
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
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
                children: [
                  Text(
                    due_time,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    due_date,
                    style: const TextStyle(
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
