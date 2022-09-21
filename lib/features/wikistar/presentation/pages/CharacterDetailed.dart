import 'package:star_wars_wiki/features/wikistar/data/models/starwars_characters_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:star_wars_wiki/features/wikistar/presentation/pages/MainPage.dart';

import '../../data/models/character_detailed.dart';

class CharacterDetailed extends StatefulWidget {
  const CharacterDetailed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterDetailedState();
}

class _CharacterDetailedState extends State<CharacterDetailed> {
  int currentChar = 1;
  List<Detail> charactersDetails = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getDetails({bool isRefresh = false}) async {
    if (isRefresh) {
      currentChar = 1;
    } else {
      if (currentChar > 82) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse("https://swapi.dev/api/people/$currentChar");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = detailsFromJson(response.body);

      if (isRefresh) {
        charactersDetails = result.detalhes;
      } else {
        charactersDetails.addAll(result.detalhes);
      }

      currentChar++;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text('E, lá, vamos nós...')),
        body: BodyWidget(),
      ),
    );
  }
}


class BodyWidget extends StatefulWidget {
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Teste'),
          subtitle: Text('Pra ver se sou burro mesmo ou não.'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('é, você é burro');
          },
        )
      ],
    );
  }
}
