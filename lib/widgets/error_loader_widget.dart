import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorLoaderWidget extends StatelessWidget {
  String errorText = '';

  ErrorLoaderWidget({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height, // Full screen height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 125,
              child: Lottie.asset('assets/images/reload.json'),
            ),
            const SizedBox(height: 10),
            Text(
              errorText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
