import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_wiki/features/wikistar/data/models/starwars_characters_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_wars_wiki/features/wikistar/presentation/pages/CharacterDetailed.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 1;

  late int count;

  List<Character> characters = [];

  final RefreshController refreshController =
  RefreshController(initialRefresh: true);

  Future<bool> getCharacterData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= 10) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri =
    Uri.parse("https://swapi.dev/api/people/?page=$currentPage&size=10");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = charactersDataFromJson(response.body);

      if (isRefresh) {
        characters = result.results;
      } else {
        characters.addAll(result.results);
      }
      currentPage++;

      count = result.count;

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
    getCharacterData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Wiki'),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getCharacterData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getCharacterData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              final character = characters[index];
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
                onTap: () {
                  charDetails(context);
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: characters.length),
      ),
    );
  }

  void charDetails(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CharacterDetailed()));
  }
}