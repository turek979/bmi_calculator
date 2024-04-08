import 'package:flutter/material.dart';

enum MeasureUnit { _cm, _in }

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

const Widget _gap = SizedBox(width: 40);
MeasureUnit _selectedUnit = MeasureUnit._cm;

String displayingUnit() {
  if (_selectedUnit == MeasureUnit._in) {
    return 'in';
  } else {
    return 'cm';
  }
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  label: const Text('Height'),
                  suffixText: displayingUnit(),
                ),
              ),
            ),
            _gap,
            DropdownMenu(
              label: const Text('Unit'),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: MeasureUnit._cm, label: 'cm'),
                DropdownMenuEntry(value: MeasureUnit._in, label: 'in'),
              ],
              onSelected: (value) {
                setState(() {
                  _selectedUnit = value!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}