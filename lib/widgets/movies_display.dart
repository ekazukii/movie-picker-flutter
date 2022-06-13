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
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      genreIds: json['genre_ids'].cast<int>(),
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
  var favs = HashSet<String>();

  _MoviesDisplay() {
    getFavs();
  }

  void getFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList('favs2');

    setState(() {
      if (stringList == null) {
        favs = HashSet<String>();
        return;
      }

      favs = HashSet<String>.from(stringList);
    });
  }

  void setFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favs2', favs.toList());
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
                icon: favs.contains("${movie.id}|${movie.posterPath}")
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                tooltip: 'Ajoute le film aux favoris',
                onPressed: () {
                  setState(() {
                    if (favs.contains("${movie.id}|${movie.posterPath}")) {
                      favs.remove("${movie.id}|${movie.posterPath}");
                    } else {
                      favs.add("${movie.id}|${movie.posterPath}");
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
