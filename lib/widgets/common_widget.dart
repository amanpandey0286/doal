import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
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
          child: Lottie.asset('assets/images/login.json'),
        ),
      ],
    );
  }
}
