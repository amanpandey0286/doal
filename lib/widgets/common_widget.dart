import 'package:flutter/material.dart';

class common_widget extends StatelessWidget {
  const common_widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 35.0),
          child: Text(
            "Doal",
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 55.0,
            ),
          ),
        ),
        SizedBox(
          height: 250.0,
          child: Image.asset("assets/images/login_anim.gif"),
        ),
      ],
    );
  }
}
