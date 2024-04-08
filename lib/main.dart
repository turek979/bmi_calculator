import 'package:flutter/material.dart';
import 'package:my_app/views/login_view.dart';

void main() {
  return runApp(
    const MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      home: BmiCalculator(),
    ),
  );
}
