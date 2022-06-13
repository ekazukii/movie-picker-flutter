// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import './trending.dart';
import './picker.dart';
import './saved.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const AppContainer(), // Wrap your app
  ));
}

class AppContainer extends StatelessWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Awesome Movie Picker",
      home: const MyApp(),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// TODO: Use TabController
class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Trending(),
    Picker(),
    Saved(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Movie Picker'),
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

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('$_count', style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}
