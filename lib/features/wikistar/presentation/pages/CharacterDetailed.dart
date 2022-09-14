import 'package:star_wars_wiki/features/wikistar/data/models/starwars_characters_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:star_wars_wiki/features/wikistar/presentation/pages/MainPage.dart';

import '../../data/models/character_detailed.dart';

class CharacterDetailed extends StatefulWidget {
  @override
  State<CharacterDetailed> createState() => _CharacterDetailedState();
}

class _CharacterDetailedState extends State<CharacterDetailed> {
  int currentChar = 1;

  late int count;

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

      count = result.detalhes as int;

      print(response.body);
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
    return Scaffold(
      appBar: AppBar(title: const Text("Teste")),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final character = charactersDetails[index];
            return ListTile(
              title: Text(character.name),
              subtitle: Text(character.height),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(character.gender),
                  Text(character.mass),
                ],
              ),
              dense: false,
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: charactersDetails.length),
    );
  }
}
