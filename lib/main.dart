// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const AppContainer());
}

class AppContainer extends StatelessWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Hey hey",
      home: MyApp()
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(),
    Text("Page 2"),
    Text("Page 3"),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: _pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Tendances',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Choisir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Sauvegardés',
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ), 
    );
  }

    void onTapHandler(int index)  {
      setState(() {
        selectedIndex = index;
      });
    }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  // Counter
  int _count = 1;

    void onPressed() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedButton(
        onPressed: onPressed, 
        child: Text('$_count', style: Theme.of(context).textTheme.headline4),
      ),
    );
  }

}