import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(100),
  ),
);
