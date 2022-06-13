import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/movies_display.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _Saved();
}

class _Saved extends State<Saved> {
  var favs = <Movie>[];

  _Saved() {
    getFavs();
  }

  void getFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList('favs2');
    if (stringList != null) {
      final Iterable<Movie> mvs = stringList.map((e) {
        final splitted = e.split("|");
        return Movie(id: int.parse(splitted[0]), posterPath: splitted[1]);
      });

      setState(() {
        favs = List<Movie>.from(mvs);
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return MoviesDisplay(movies: favs);
  }
}
