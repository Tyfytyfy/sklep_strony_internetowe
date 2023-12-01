import 'package:flutter/material.dart';

class GestureDetectorText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GestureDetectorText({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Inter',
          fontSize: 12,
          letterSpacing: 0,
          fontWeight: FontWeight.normal,
          height: 1,
        ),
      ),
    );
  }
}
