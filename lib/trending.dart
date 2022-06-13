import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './widgets/movies_display.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _Trending();
}

class _Trending extends State<Trending> {
  List<Movie> mvs = [];

  getMovies() async {
    final response = await http
        .get(Uri.parse('https://amp.ekazuki.fr/api/getTrendingMovies'));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body)["results"];

      setState(() {
        data.forEach((e) {
          mvs.add(Movie.fromJson(e));
        });
      });
    }
  }

  _Trending() {
    getMovies();
  }

  @override
  Widget build(BuildContext ctx) {
    return MoviesDisplay(movies: mvs);
  }
}
