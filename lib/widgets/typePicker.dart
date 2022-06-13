import 'dart:collection';

import 'package:flutter/material.dart';

class TypePicker extends StatefulWidget {
  const TypePicker({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<HashSet<String>> onChanged;

  @override
  State<TypePicker> createState() => _TypePickerState();
}

class _TypePickerState extends State<TypePicker> {
  HashMap<int, String> _types = HashMap<int, String>();
  HashSet<String> _typesSelected = HashSet<String>();

  _TypePickerState() {
    _types.addAll({
      28: "Action",
      12: "Aventure",
      16: "Animation",
      35: "Comédie",
      80: "Crime",
      99: "Documentaire",
      18: "Drame",
      10751: "Famille",
      14: "Fantastique",
      36: "Histoire",
      27: "Horreur",
      10402: "Musique",
      9648: "Mystère",
      10749: "Romance",
      878: "Science-fiction",
      10770: "Film TV",
      53: "Thriller",
      10752: "Guerre",
      37: "Western",
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    _types.forEach((key, value) {
      widgets.add(
        CheckboxListTile(
          title: Text(value),
          value: _typesSelected.contains(key.toString()),
          onChanged: (bool? value) {
            setState(() {
              if (value != null && value) {
                _typesSelected.add(key.toString());
              } else {
                _typesSelected.remove(key.toString());
              }
            });
            widget.onChanged(_typesSelected);
          },
        ),
      );
    });

    return SizedBox(
      height: 250,
      child: Scrollbar(
        child: ListView(
          primary: false,
          children: widgets,
        ),
      ),
    );
  }
}
