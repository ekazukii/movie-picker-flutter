import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  final int id;

  const MovieDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetails();
}

class _MovieDetails extends State<MovieDetails> {
  var title = "";
  var posterPath = "";
  var release = "";
  var desc = "";
  List<String> types = [];

  @override
  initState() {
    getMovie();
    super.initState();
  }

  getMovie() async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/api/getDetailsOfMovie?id=${widget.id}&region=fr-FR'));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        title = data["title"];
        posterPath = data["poster_path"];
        release = data["release_date"];
        desc = data["overview"];
        //types = data["genres"].map((e) => {e["name"]}).toList().cast<String>();
        data["genres"].forEach((e) {
          //print(e);
          types.add(e["name"].toString());
          print(e["name"]);
          //print(e["names"].runtimeType);
        });
      });
    }
  }

  @override
  Widget build(BuildContext ctw) {
    if (title.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    print(types.runtimeType);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500/$posterPath",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(types.join(" - "))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("Sortie: $release")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Text(desc, style: Theme.of(ctw).textTheme.bodyText1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      final Uri url = Uri.parse(
                          'https://www.themoviedb.org/movie/${widget.id}/watch?locale=FR');
                      launchUrl(url);
                    },
                    child: const Text("Regarder Maintenant"))
              ],
            ),
          ],
        ));
  }
}
