import 'package:flutter/material.dart';

class ImportantBadge extends StatelessWidget {
  final Widget child;
  final bool impCheck;

  const ImportantBadge({
    Key? key,
    required this.child,
    required this.impCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (impCheck) // Conditionally show the badge
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
      ],
    );
  }
}
