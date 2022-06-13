import 'dart:collection';

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/type_picker.dart';
import 'widgets/providers_picker.dart';

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<Picker> createState() => _Picker();
}

class _Picker extends State<Picker> {
  RangeValues _currentRangeValues = const RangeValues(30, 60);
  double _minRank = 50;
  HashSet<String> _typesSelected = HashSet<String>();
  HashSet<int> _providersSelected = HashSet<int>();

  String minutesToHoursAndMinutes(double mins) {
    final hours = (mins / 60).floor();
    final minutes = (mins % 60).floor();
    return '$hours h $minutes min';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(children: [
            const Text("Genre de film : "),
            TypePicker(onChanged: (HashSet<String> vals) {
              setState(() {
                _typesSelected = vals;
              });
            }),
          ]),
        ),
        Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text(
                    'Qui dure entre : ${minutesToHoursAndMinutes(_currentRangeValues.start)} et ${minutesToHoursAndMinutes(_currentRangeValues.end)} '),
                RangeSlider(
                    onChanged: (RangeValues newValues) {
                      setState(() {
                        _currentRangeValues = newValues;
                      });
                    },
                    divisions: 180,
                    labels: RangeLabels(
                      minutesToHoursAndMinutes(_currentRangeValues.start),
                      minutesToHoursAndMinutes(_currentRangeValues.end),
                    ),
                    max: 180,
                    min: 0,
                    values: _currentRangeValues),
              ],
            )),
        Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const Text("Sur les plateformes : "),
                ProvidersPicker(onChanged: (HashSet<int> vals) {
                  setState(() {
                    _providersSelected = vals;
                  });
                }),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Text("Avec une note minimum de ${_minRank.round()}% : "),
              Slider(
                value: _minRank,
                label: _minRank.round().toString(),
                min: 0.0,
                max: 100.0,
                divisions: 100,
                onChanged: (double value) {
                  setState(() {
                    _minRank = value;
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
