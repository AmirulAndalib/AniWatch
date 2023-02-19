// ignore_for_file: file_names

import 'dart:convert';

class StreamingServer {
  StreamingServer({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory StreamingServer.fromRawJson(String str) =>
      StreamingServer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamingServer.fromJson(Map<String, dynamic> json) =>
      StreamingServer(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
