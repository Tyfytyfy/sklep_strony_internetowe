import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown.shade400,
      child: Center(
        child: SpinKitPouringHourGlass(
          color: (Colors.brown[600])!,
          size: 50.0,
        ),
      ),
    );
  }
}
