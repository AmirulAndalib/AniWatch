// To parse this JSON data, do
//
//     final anilistPopular = anilistPopularFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

AnilistPopular anilistPopularFromJson(String str) =>
    AnilistPopular.fromJson(json.decode(str));

String anilistPopularToJson(AnilistPopular data) => json.encode(data.toJson());

class AnilistPopular {
  AnilistPopular({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  int currentPage;
  bool hasNextPage;
  List<Result> results;

  factory AnilistPopular.fromJson(Map<String, dynamic> json) => AnilistPopular(
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
    required this.image,
    this.trailer,
    required this.description,
    this.status,
    required this.cover,
    required this.rating,
    required this.releaseDate,
    this.color,
    required this.genres,
    required this.totalEpisodes,
    required this.duration,
    this.type,
  });

  String id;
  int malId;
  Title title;
  String image;
  Trailer? trailer;
  String description;
  Status? status;
  String cover;
  int rating;
  int releaseDate;
  String? color;
  List<String> genres;
  int totalEpisodes;
  int duration;
  Type? type;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        malId: json["malId"],
        title: Title.fromJson(json["title"]),
        image: json["image"],
        trailer:
            json["trailer"] != null ? Trailer.fromJson(json["trailer"]) : null,
        description: json["description"],
        status: statusValues.map[json["status"]],
        cover: json["cover"] ?? '',
        rating: json["rating"] ?? 0,
        releaseDate: json["releaseDate"] ?? 0,
        color: json["color"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        totalEpisodes: json["totalEpisodes"],
        duration: json["duration"] ?? 0,
        type: typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "malId": malId,
        "title": title.toJson(),
        "image": image,
        "trailer": trailer?.toJson(),
        "description": description,
        "status": statusValues.reverse[status],
        "cover": cover,
        "rating": rating,
        "releaseDate": releaseDate,
        "color": color,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "totalEpisodes": totalEpisodes,
        "duration": duration,
        "type": typeValues.reverse[type],
      };
}

enum Status { COMPLETED, ONGOING }

final statusValues =
    EnumValues({"Completed": Status.COMPLETED, "Ongoing": Status.ONGOING});

class Title {
  Title({
    required this.romaji,
    required this.english,
    required this.native,
    required this.userPreferred,
  });

  String romaji;
  String english;
  String native;
  String userPreferred;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        romaji: json["romaji"] ?? '',
        english: json["english"] ?? '',
        native: json["native"] ?? '',
        userPreferred: json["userPreferred"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "romaji": romaji,
        "english": english,
        "native": native,
        "userPreferred": userPreferred,
      };
}

class Trailer {
  Trailer({
    this.id,
    this.site,
    this.thumbnail,
  });

  String? id;
  Site? site;
  String? thumbnail;

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        id: json["id"] ?? '',
        site: siteValues.map[json["site"]],
        thumbnail: json["thumbnail"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site": siteValues.reverse[site],
        "thumbnail": thumbnail,
      };
}

enum Site { YOUTUBE }

final siteValues = EnumValues({"youtube": Site.YOUTUBE});

enum Type { TV, MOVIE }

final typeValues = EnumValues({"MOVIE": Type.MOVIE, "TV": Type.TV});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
