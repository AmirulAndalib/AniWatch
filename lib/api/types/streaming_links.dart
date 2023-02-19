// To parse this JSON data, do
//
//     final streamingLinks = streamingLinksFromJson(jsonString);

import 'dart:convert';

class StreamingLinks {
  StreamingLinks({
    required this.headers,
    required this.sources,
    required this.download,
  });

  final Headers headers;
  final List<Source> sources;
  final String download;

  factory StreamingLinks.fromRawJson(String str) =>
      StreamingLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamingLinks.fromJson(Map<String, dynamic> json) => StreamingLinks(
        headers: Headers.fromJson(json["headers"]),
        sources:
            List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        download: json["download"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "download": download,
      };
}

class Headers {
  Headers({
    required this.referer,
  });

  final String referer;

  factory Headers.fromRawJson(String str) => Headers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
        referer: json["Referer"],
      );

  Map<String, dynamic> toJson() => {
        "Referer": referer,
      };
}

class Source {
  Source({
    required this.url,
    required this.isM3U8,
    required this.quality,
  });

  final String url;
  final bool isM3U8;
  final String quality;

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        url: json["url"],
        isM3U8: json["isM3U8"],
        quality: json["quality"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "isM3U8": isM3U8,
        "quality": quality,
      };
}
