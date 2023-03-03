import 'package:aniwatch/anime_info.dart';
import 'package:aniwatch/api/types/info.dart';
import 'package:aniwatch/watch_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart';

import 'helpers/pop_up.dart';

class UserProgress extends StatefulWidget {
  const UserProgress({Key? key}) : super(key: key);

  @override
  State<UserProgress> createState() => _UserProgressState();
}

class _UserProgressState extends State<UserProgress> {
  final db = Localstore.instance;
  late Future<Map<String, dynamic>?> futureProgress;

  @override
  void initState() {
    super.initState();
    futureProgress = db.collection('watch-list').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: futureProgress,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var entries = snapshot.data!.values.toList(growable: true);

              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    var anime = AnilistInfo.fromJson(entries[index]["anime"]);
                    var episode = Episodes.fromJson(entries[index]["episode"]);
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => Watch(episode: episode, anime: anime)),
                      onLongPress: () async {
                        setState(() {});
                        ShowToast(context,
                            "Removed ${anime.title?.english} from progress");
                        await db
                            .collection('watch-list')
                            .doc(anime.id)
                            .delete();
                      },
                      child: ListTile(
                        title: Text(anime.title?.english ?? "No title"),
                        subtitle: Text(
                            "Episode ${episode.number} - ${episode.title}"),
                        leading: SizedBox(child: Image.network(anime.image!)),
                        trailing:
                            SizedBox(child: Image.network(episode.image!)),
                      ),
                    );
                  });
              // return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
