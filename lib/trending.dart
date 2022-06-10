import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Trending extends StatefulWidget {
  const Trending({ Key? key }) : super(key: key);

  @override
  State<Trending> createState() => _Trending();
}

class _Trending extends State<Trending> {

  var favs = HashSet();

  _Trending() {
    getFavs();
  }

  void getFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList('favs');
    print(stringList);

    if(stringList!.isEmpty) {
      setState(() {
        favs = HashSet<int>();
      });
    }

    final intList = stringList.map((e) => int.parse(e)).toList();
    setState(() {
      favs = HashSet<int>.from(intList);
    });
  }

  void setFavs() async {
    print(favs);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favs', favs.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final cards = <Card>[];
    //getFavs();
    //final prefs = await SharedPreferences.getInstance();


    for (var i = 1; i <= 10; i++) {
      cards.add(Card(
        child: Column(
          children: [
            const Image(image: NetworkImage("https://image.tmdb.org/t/p/w300/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: 
                  const Text("Plus d'info"),
                ),
                IconButton(
                  icon: favs.contains(i) ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border),
                  tooltip: 'Ajoute le film aux favoris',
                  onPressed: () {
                    setState(() {
                      if (favs.contains(i)) {
                        favs.remove(i);
                      } else {
                        favs.add(i);
                      }
                      setFavs();
                    });
                  },
                ),
              ],
            )
          ]
        ),
      ));
    }

    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.56,
        children: cards
      ),
    );
  }
}