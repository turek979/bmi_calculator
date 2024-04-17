import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

enum MeasureHeightUnit { _cm, _in }

enum MeasureWeightUnit { _kg, _lb }

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

String? displayedBmi;

final _heightController = TextEditingController();
final _weightController = TextEditingController();

const Widget _widthGap = SizedBox(width: 40);
const Widget _heightGap = SizedBox(height: 40);
MeasureHeightUnit _selectedHeightUnit = MeasureHeightUnit._cm;
MeasureWeightUnit _selectedWeightUnit = MeasureWeightUnit._kg;

String displayingHeightUnit() {
  if (_selectedHeightUnit == MeasureHeightUnit._in) {
    return 'in';
  } else {
    return 'cm';
  }
}

String displayingWeightUnit() {
  if (_selectedWeightUnit == MeasureWeightUnit._lb) {
    return 'lb';
  } else {
    return 'kg';
  }
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  _calculateEuBmi(double weight, double height) {
    double bmi = weight / (pow((height / 100), 2));
    displayedBmi = bmi.toStringAsFixed(1);
  }

  _calculateEnBmi(double weight, double height) {
    double bmi = (703 * weight) / (pow(height, 2));
    displayedBmi = bmi.toStringAsFixed(1);
  }

  displayBmi(double height, double weight) {
    if (_selectedHeightUnit == MeasureHeightUnit._cm &&
        _selectedWeightUnit == MeasureWeightUnit._kg) {
      return _calculateEuBmi(weight, height);
    } else if (_selectedHeightUnit == MeasureHeightUnit._in &&
        _selectedWeightUnit == MeasureWeightUnit._lb) {
      return _calculateEnBmi(weight, height);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid units'),
          content: const Text(
              'Please make sure that you choose corresponding units'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  String displayedValue() {
    if (displayedBmi == null) {
      return 'No BMI yet';
    } else {
      return 'Your current BMI is $displayedBmi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _heightController,
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  label: const Text('Height'),
                  suffixText: displayingHeightUnit(),
                ),
              ),
            ),
            _widthGap,
            DropdownMenu(
              label: const Text('Unit'),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: MeasureHeightUnit._cm, label: 'cm'),
                DropdownMenuEntry(value: MeasureHeightUnit._in, label: 'in'),
              ],
              onSelected: (value) {
                setState(() {
                  _selectedHeightUnit = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _weightController,
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  label: const Text('Weight'),
                  suffixText: displayingWeightUnit(),
                ),
              ),
            ),
            _widthGap,
            DropdownMenu(
              label: const Text('Unit'),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: MeasureWeightUnit._kg, label: 'kg'),
                DropdownMenuEntry(value: MeasureWeightUnit._lb, label: 'lb'),
              ],
              onSelected: (value) {
                setState(() {
                  _selectedWeightUnit = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 42),
        ElevatedButton(
          onPressed: () {
            setState(() {
              displayBmi(
                double.parse(_heightController.text),
                double.parse(_weightController.text),
              );
            });
          },
          child: const Text(
            'Calculate!',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        _heightGap,
        Center(
          child: Card(
            child: SizedBox(
              width: 760,
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  displayedValue(),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
