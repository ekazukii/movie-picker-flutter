import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// typedef Movie = {
//   'id': int,
//   'title': String,
//   'poster_path': String,
//   'overview': String,
//   'genres_ids': List<int>,
// }

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<int> genresIds;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genresIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      genresIds: json['genres_ids'],
    );
  }
}

class MoviesDisplay extends StatefulWidget {
  const MoviesDisplay({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  State<MoviesDisplay> createState() => _MoviesDisplay();
}

class _MoviesDisplay extends State<MoviesDisplay> {
  var favs = HashSet();

  _MoviesDisplay() {
    getFavs();
  }

  void getFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList('favs');

    if (stringList!.isEmpty) {
      return setState(() {
        favs = HashSet<int>();
      });
    }

    final intList = stringList.map((e) => int.parse(e)).toList();
    setState(() {
      favs = HashSet<int>.from(intList);
    });
  }

  void setFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favs', favs.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final cards = <Card>[];
    //getFavs();
    //final prefs = await SharedPreferences.getInstance();

    for (var movie in widget.movies) {
      cards.add(Card(
        child: Column(children: [
          Image(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w300${movie.posterPath}")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Plus d'info"),
              ),
              IconButton(
                icon: favs.contains(movie.id)
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                tooltip: 'Ajoute le film aux favoris',
                onPressed: () {
                  setState(() {
                    if (favs.contains(movie.id)) {
                      favs.remove(movie.id);
                    } else {
                      favs.add(movie.id);
                    }
                    setFavs();
                  });
                },
              ),
            ],
          )
        ]),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.56,
          children: cards),
    );
  }
}
