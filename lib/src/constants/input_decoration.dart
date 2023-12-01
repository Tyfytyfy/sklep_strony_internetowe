import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: const BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(100),
  ),
);
