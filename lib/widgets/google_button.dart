import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              width: 1.5,
              color: Colors.white54,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/google.png"),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Continue with Google",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
