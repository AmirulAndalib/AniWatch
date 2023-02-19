import 'dart:convert';
import 'package:aniwatch/api/types/Info.dart';
import 'package:aniwatch/api/types/Trending.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../consts.dart';
import 'types/Popular.dart';
import 'types/StreamingServers.dart';
import 'types/search_result.dart';
import 'types/streaming_links.dart';

class AnilistMeta {
  final client = http.Client();

  Future<AnilistPopular?> getPopular() async {
    var response = await client
        .get(Uri.parse('$API_ENDPOINT/meta/anilist/popular?perPage=30'));
    // var request = http.Request(
    //     'GET', Uri.parse('$API_ENDPOINT/meta/anilist/popular?perPage=30'));

    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return anilistPopularFromJson(response.body);
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return null;
    }
  }

  Future<AnilistTrending?> getTrending() async {
    var response = await client
        .get(Uri.parse('$API_ENDPOINT/meta/anilist/trending?perPage=30'));

    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return AnilistTrending.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return null;
    }
  }

  Future<AnilistInfo?> getInfo(int id) async {
    var response = await client.get(Uri.parse(
        "$API_ENDPOINT/meta/anilist/info/$id?provider=$ANIME_PROVIDER"));

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return AnilistInfo.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return null;
    }
  }

  Future<List<StreamingServer>?> getServers(String episodeId) async {
    var response = await client.get(
        Uri.parse('$API_ENDPOINT/anime/$ANIME_PROVIDER/servers/$episodeId'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<StreamingServer> servers = List<StreamingServer>.from(
          l.map((model) => StreamingServer.fromJson(model)));
      return servers;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
    return null;
  }

  Future<StreamingLinks?> getStreamingLinks(String episodeId) async {
    var response = await client.get(Uri.parse(
        "$API_ENDPOINT/meta/anilist/watch/$episodeId?provider=$ANIME_PROVIDER"));
    if (response.statusCode == 200) {
      return StreamingLinks.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
    return null;
  }

  Future<SearchResult?> searchAnime(String query) async {
    var response =
        await client.get(Uri.parse("$API_ENDPOINT/meta/anilist/$query"));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return SearchResult.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
    return null;
  }
}
