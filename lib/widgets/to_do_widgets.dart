import 'package:doal/widgets/important_badge_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoWidget extends StatelessWidget {
  ToDoWidget(
      {super.key,
      required this.due_date,
      required this.due_time,
      required this.title,
      required this.check,
      required this.remCheck,
      required this.impCheck,
      required this.onChange,
      required this.index});
  var due_date = '';
  var due_time = '';
  var title = '';
  final bool remCheck;
  final bool check;
  final bool impCheck;
  final Function onChange;
  final String index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ImportantBadge(
        impCheck: impCheck,
        child: Container(
          height: 80.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: [
                Color(0xFFECA414),
                Color(0xFFC63956),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.8],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (value) {
                          onChange(index);
                        },
                        value: check,
                      ),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Flexible(
                            child: Text(
                              'Remainder: ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            remCheck ? 'On' : 'Off',
                            style: const TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
