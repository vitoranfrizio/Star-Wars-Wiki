

import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    required this.count,
    required this.next,
    required this.previous,
    required this.detalhes,
  });

  int count;
  String next;
  dynamic previous;
  List<Detail> detalhes;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    detalhes: List<Detail>.from(json["detalhes"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "detalhes": List<dynamic>.from(detalhes.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  List<String> films;
  List<dynamic> species;
  List<String> vehicles;
  List<String> starships;
  String created;
  String edited;
  String url;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    name: json["name"],
    height: json["height"],
    mass: json["mass"],
    hairColor: json["hair_color"],
    skinColor: json["skin_color"],
    eyeColor: json["eye_color"],
    birthYear: json["birth_year"],
    gender: json["gender"],
    homeworld: json["homeworld"],
    films: List<String>.from(json["films"].map((x) => x)),
    species: List<dynamic>.from(json["species"].map((x) => x)),
    vehicles: List<String>.from(json["vehicles"].map((x) => x)),
    starships: List<String>.from(json["starships"].map((x) => x)),
    created: json["created"],
    edited: json["edited"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "height": height,
    "mass": mass,
    "hair_color": hairColor,
    "skin_color": skinColor,
    "eye_color": eyeColor,
    "birth_year": birthYear,
    "gender": gender,
    "homeworld": homeworld,
    "films": List<dynamic>.from(films.map((x) => x)),
    "species": List<dynamic>.from(species.map((x) => x)),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "starships": List<dynamic>.from(starships.map((x) => x)),
    "created": created,
    "edited": edited,
    "url": url,
  };
}
