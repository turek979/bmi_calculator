import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/simple_calculator.dart';

enum Complexity { complex, simple }

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  Complexity selected = Complexity.simple;
  final Widget _gap = const SizedBox(height: 20);

  var cm;
  var inch;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _gap,
                Center(
                  child: Card(
                    child: SizedBox(
                      width: 760,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Your current BMI is ...',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _gap,
                SegmentedButton<Complexity>(
                  segments: const <ButtonSegment<Complexity>>[
                    ButtonSegment<Complexity>(
                      value: Complexity.simple,
                      label: Text('Simple'),
                    ),
                    ButtonSegment<Complexity>(
                      value: Complexity.complex,
                      label: Text('Complex'),
                    ),
                  ],
                  selected: <Complexity>{selected},
                  onSelectionChanged: (Set<Complexity> newSelection) {
                    setState(() {
                      selected = newSelection.first;
                    });
                  },
                ),
                _gap,
                const SimpleCalculator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
