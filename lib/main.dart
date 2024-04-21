import 'package:flutter/material.dart';
import 'package:my_app/views/main_view.dart';

void main() {
  return runApp(
    const MaterialApp(
      title: 'BMI Calculator',
      home: BmiCalculator(),
    ),
  );
}
