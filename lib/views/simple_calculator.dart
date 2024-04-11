import 'package:flutter/material.dart';

enum MeasureHeightUnit { _cm, _in }

enum MeasureWeightUnit { _kg, _lb }

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

final _heightController = TextEditingController();
final _weightController = TextEditingController();

const Widget _gap = SizedBox(width: 40);
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

double _calculateEuBmi(double weight, double height) {
  double bmi = weight / (height * 2);
  return bmi;
}

double _calculateEnBmi(double weight, double height) {
  double bmi = 703 * (weight / (height * 2));
  return bmi;
}

displayBmi(double height, double weight) {
  if (_selectedHeightUnit == MeasureHeightUnit._cm &&
      _selectedWeightUnit == MeasureWeightUnit._kg) {
    _calculateEuBmi(weight, height);
  } else if (_selectedHeightUnit == MeasureHeightUnit._in &&
      _selectedWeightUnit == MeasureWeightUnit._lb) {
    _calculateEnBmi(weight, height);
  } else {
    _calculateEnBmi(weight, height);
  }
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
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
            _gap,
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
            _gap,
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
              displayBmi(
                double.parse(_heightController.text),
                double.parse(_weightController.text),
              );
            },
            child: const Text(
              'Calculate!',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ))
      ],
    );
  }
}
