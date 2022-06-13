import 'dart:collection';

import 'package:flutter/material.dart';

class ProvidersPicker extends StatefulWidget {
  const ProvidersPicker({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<HashSet<int>> onChanged;

  @override
  State<ProvidersPicker> createState() => _ProvidersPicker();
}

class _ProvidersPicker extends State<ProvidersPicker> {
  final HashMap<List<int>, String> _providers = HashMap<List<int>, String>();
  final HashSet<int> _providersSelected = HashSet<int>();

  _ProvidersPicker() {
    _providers.addAll({
      [
        8
      ]: "https://image.tmdb.org/t/p/w92/t2yyOv40HZeVlLjYsCsPHnWLk4W.jpg", // Netflix
      [
        119,
        9,
        10,
        194
      ]: "https://image.tmdb.org/t/p/w92/emthp39XA2YScoYL1p0sdbAH2WA.jpg", // Amazon
      [
        381
      ]: "https://image.tmdb.org/t/p/w92/hGvUo8KZTRLDZWcfFJS3gA8aenB.jpg", // Canal +
      [
        35
      ]: "https://image.tmdb.org/t/p/w92/6uhKBfmtzFqOcLousHwZuzcrScK.jpg", // Apple TV Plus
      [
        58
      ]: "https://image.tmdb.org/t/p/w92/knpqBvBQjyHnFrYPJ9bbtUCv6uo.jpg", // Canal + VOD
      [
        415
      ]: "https://image.tmdb.org/t/p/w92/fN1aQj1gpWXGW0gwcGlHJYQHUeS.jpg", // ADN
      [
        564
      ]: "https://image.tmdb.org/t/p/w92/5uUdbTzTj4N2Wso1FTt2rRoJ5Da.jpg", // Salto
      [
        337
      ]: "https://image.tmdb.org/t/p/w92/7rwgEs15tFwyR9NPQ5vpzxTj19Q.jpg", // Disney+
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];

    _providers.forEach((key, value) {
      images.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (_providersSelected.contains(key[0])) {
                for (var element in key) {
                  _providersSelected.remove(element);
                }
              } else {
                for (var element in key) {
                  _providersSelected.add(element);
                }
              }
              widget.onChanged(_providersSelected);
            });
          },
          child: Container(
            decoration: (_providersSelected.contains(key[0]))
                ? BoxDecoration(
                    border: Border.all(width: 5, color: Colors.blue),
                  )
                : null,
            margin: const EdgeInsets.all(5),
            child: Image.network(
              value,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });

    return SizedBox(
      height: 350,
      child: GridView.count(crossAxisCount: 3, children: images),
    );
  }
}
