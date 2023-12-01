import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String semanticsLabel;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color.fromARGB(40, 96, 85, 62),
      elevation: 0,
      child: SvgPicture.asset(
        imagePath,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}