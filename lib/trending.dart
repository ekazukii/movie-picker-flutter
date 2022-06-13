import 'package:flutter/material.dart';

import './widgets/movies_display.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _Trending();
}

class _Trending extends State<Trending> {
  @override
  Widget build(BuildContext ctx) {
    List<Movie> mvs = [];
    for (var i = 0; i <= 10; i++) {
      mvs.add(Movie(
          genresIds: [0],
          id: i,
          overview: '',
          posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
          title: 'Hey frerot n$i'));
    }

    return MoviesDisplay(movies: mvs);
  }
}
