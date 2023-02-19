import 'dart:convert';

import 'Result.dart';

class AnilistTrending {
  AnilistTrending({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  int currentPage;
  bool hasNextPage;
  List<Result> results;

  factory AnilistTrending.fromRawJson(String str) =>
      AnilistTrending.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnilistTrending.fromJson(Map<String, dynamic> json) =>
      AnilistTrending(
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
