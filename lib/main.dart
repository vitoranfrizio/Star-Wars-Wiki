import 'dart:io';

import 'package:flutter/material.dart';
import 'features/wikistar/presentation/pages/MainPage.dart';

void main() {
  runApp(const StarWarsWiki());
}

class StarWarsWiki extends StatelessWidget {
  const StarWarsWiki({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
