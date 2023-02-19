import 'dart:convert';

class Result {
  Result({
    required this.id,
    required this.malId,
    required this.title,
    required this.image,
    required this.trailer,
    required this.description,
    required this.status,
    required this.cover,
    required this.rating,
    required this.releaseDate,
    //required this.color,
    required this.genres,
    required this.totalEpisodes,
    required this.duration,
    // required this.type,
  });

  String id;
  int malId;
  Title title;
  String image;
  Trailer trailer;
  String description;
  Status status;
  String cover;
  int rating;
  int releaseDate;
  //String color;
  List<String> genres;
  int totalEpisodes;
  int duration;
  //Type type;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        malId: json["malId"],
        title: Title.fromJson(json["title"]),
        image: json["image"],
        trailer: Trailer.fromJson(json["trailer"]),
        description: json["description"],
        status: statusValues.map[json["status"]]!,
        cover: json["cover"],
        rating: json["rating"],
        releaseDate: json["releaseDate"],
        // color: json["color"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        totalEpisodes: json["totalEpisodes"],
        duration: json["duration"],
        // type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "malId": malId,
        "title": title.toJson(),
        "image": image,
        "trailer": trailer.toJson(),
        "description": description,
        "status": statusValues.reverse[status],
        "cover": cover,
        "rating": rating,
        "releaseDate": releaseDate,
        // "color": color,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "totalEpisodes": totalEpisodes,
        "duration": duration,
        // "type": typeValues.reverse[type],
      };
}

enum Status { ONGOING, COMPLETED }

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

class Trailer {
  Trailer({
    this.id,
    this.site,
    this.thumbnail,
  });

  String? id;
  String? site;
  String? thumbnail;

  factory Trailer.fromRawJson(String str) => Trailer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        id: json["id"],
        site: json["site"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site": site,
        "thumbnail": thumbnail,
      };
}

enum Type { TV }

final typeValues = EnumValues({"TV": Type.TV});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
