import 'dart:collection';

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import './widgets/typePicker.dart';

class Picker extends StatefulWidget {
  const Picker({ Key? key }) : super(key: key);

  @override
  State<Picker> createState() => _Picker();
}

class _Picker extends State<Picker> {
  RangeValues _currentRangeValues = const RangeValues(30, 60);
  HashSet<String> _typesSelected = HashSet<String>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          values: _currentRangeValues
        ), TypePicker(onChanged: (HashSet<String> vals) {
          setState(() {
            _typesSelected = vals;
          });
        }),
      ],
    );
  }
}