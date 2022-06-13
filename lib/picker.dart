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
  double _minRank = 0.0;
  HashSet<String> _typesSelected = HashSet<String>();
  HashSet<int> _providersSelected = HashSet<int>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RangeSlider(
            onChanged: (RangeValues newValues) {
              setState(() {
                _currentRangeValues = newValues;
              });
            },
            divisions: 300,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            max: 300,
            min: 0,
            values: _currentRangeValues),
        TypePicker(onChanged: (HashSet<String> vals) {
          setState(() {
            _typesSelected = vals;
          });
        }),
        ProvidersPicker(onChanged: (HashSet<int> vals) {
          setState(() {
            _providersSelected = vals;
          });
        }),
        Slider(
          value: _minRank,
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
    );
  }
}
