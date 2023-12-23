import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String semanticsLabel;

  final String heroTag;

  const CustomFloatingActionButton(
      {super.key,
      required this.onPressed,
      required this.imagePath,
      required this.semanticsLabel,
      required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: const Color.fromARGB(240, 217, 186, 140),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SvgPicture.asset(
        imagePath,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}
