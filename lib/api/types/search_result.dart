// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

class SearchResult {
  SearchResult({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  final int currentPage;
  final bool hasNextPage;
  final List<Result> results;

  factory SearchResult.fromRawJson(String str) =>
      SearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        currentPage: json["currentPage"],
        hasNextPage: json["hasNextPage"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "hasNextPage": hasNextPage,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.malId,
    required this.title,
    required this.status,
    required this.image,
    required this.cover,
    required this.popularity,
    required this.description,
    required this.rating,
    required this.genres,
    required this.color,
    required this.totalEpisodes,
    required this.currentEpisodeCount,
    required this.type,
    required this.releaseDate,
  });

  final String id;
  final int malId;
  final Title title;
  final Status status;
  final String image;
  final String cover;
  final int popularity;
  final String description;
  final int rating;
  final List<String> genres;
  final String color;
  final int totalEpisodes;
  final int currentEpisodeCount;
  final String type;
  final int releaseDate;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        malId: json["malId"],
        title: Title.fromJson(json["title"]),
        status: statusValues.map[json["status"]]!,
        image: json["image"],
        cover: json["cover"],
        popularity: json["popularity"],
        description: json["description"],
        rating: json["rating"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        color: json["color"],
        totalEpisodes: json["totalEpisodes"],
        currentEpisodeCount: json["currentEpisodeCount"],
        type: json["type"],
        releaseDate: json["releaseDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "malId": malId,
        "title": title.toJson(),
        "status": statusValues.reverse[status],
        "image": image,
        "cover": cover,
        "popularity": popularity,
        "description": description,
        "rating": rating,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "color": color,
        "totalEpisodes": totalEpisodes,
        "currentEpisodeCount": currentEpisodeCount,
        "type": type,
        "releaseDate": releaseDate,
      };
}

enum Status { ONGOING, COMPLETED }

final statusValues =
    EnumValues({"Completed": Status.COMPLETED, "Ongoing": Status.ONGOING});

class Title {
  Title({
    required this.romaji,
    this.english,
    required this.native,
    required this.userPreferred,
  });

  final String romaji;
  final String? english;
  final String native;
  final String userPreferred;

  factory Title.fromRawJson(String str) => Title.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        romaji: json["romaji"],
        english: json["english"],
        native: json["native"],
        userPreferred: json["userPreferred"],
      );

  Map<String, dynamic> toJson() => {
        "romaji": romaji,
        "english": english,
        "native": native,
        "userPreferred": userPreferred,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
