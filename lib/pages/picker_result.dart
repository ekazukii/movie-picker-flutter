import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/movies_display.dart';

class PickerResult extends StatefulWidget {
  const PickerResult(
      {Key? key,
      required this.duration,
      required this.minRank,
      required this.types,
      required this.providers})
      : super(key: key);

  final RangeValues duration;
  final double minRank;
  final HashSet<String> types;
  final HashSet<int> providers;

  @override
  State<StatefulWidget> createState() => _PickerResult();
}

class _PickerResult extends State<PickerResult> {
  List<Movie> movies = [];

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  void getMovies() async {
    final response = await http.get(Uri.parse(
        'https://amp.ekazuki.fr/api/pickMovies?min=${widget.duration.start.toInt()}&max=${widget.duration.end.toInt()}&providers=${widget.providers.join("&providers=")}&rank=${widget.minRank.toInt()}&genders=${widget.types.join("&genders=")}&region=FR'));

    final data = jsonDecode(utf8.decode(response.bodyBytes));
    setState(() {
      data["results"].forEach((e) {
        movies.add(Movie.fromJson(e));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Resultat de recherche"),
        ),
        body: const CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Resultat de recherche"),
        ),
        body: MoviesDisplay(movies: movies));
  }
}
