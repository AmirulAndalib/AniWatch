import 'package:aniwatch/api/meta.dart';
import 'package:aniwatch/api/types/info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:localstore/localstore.dart';
import 'package:wakelock/wakelock.dart';
import 'api/types/streaming_links.dart';

class Watch extends StatefulWidget {
  final AnilistInfo anime;
  final Episodes episode;
  const Watch({super.key, required this.episode, required this.anime});

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  late Future<StreamingLinks?> futureServers;
  final db = Localstore.instance;

  Future<void> updateProgress() async {
    await db
        .collection("watch-list")
        .doc(widget.anime.id)
        .set({"anime": widget.anime, "episode": widget.episode});
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    updateProgress();
    futureServers = AnilistMeta().getStreamingLinks(widget.episode.id!);
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeData.dark().primaryColorDark,
        title: Text(widget.episode.title ?? "No title"),
        centerTitle: true,
      ),
      body: Center(
          child: FutureBuilder<StreamingLinks?>(
        future: futureServers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var defaultLink = "";
            var description = "";
            if (widget.episode.description != null) {
              description = widget.episode.description!;
            } else {
              description = "No description provided";
            }
            for (var element in snapshot.data!.sources) {
              if (element.quality == "default") {
                defaultLink = element.url;
              }
            }
            if (kDebugMode) {
              print(defaultLink);
            }
            BetterPlayerDataSource betterPlayerDataSource =
                BetterPlayerDataSource(
                    BetterPlayerDataSourceType.network, defaultLink,
                    videoFormat: BetterPlayerVideoFormat.hls,
                    headers: {
                  'User-Agent':
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
                });
            var betterPlayerController = BetterPlayerController(
                const BetterPlayerConfiguration(),
                betterPlayerDataSource: betterPlayerDataSource);
            betterPlayerController.setOverriddenFit(BoxFit.contain);
            return ListView(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer(
                    controller: betterPlayerController,
                    // 'https://cors.consumet.stream/${snapshot.data![0].url}',
                    // betterPlayerConfiguration: const BetterPlayerConfiguration(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
