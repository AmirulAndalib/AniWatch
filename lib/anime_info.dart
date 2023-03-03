import 'package:aniwatch/api/meta.dart';
import 'package:aniwatch/api/types/info.dart';
import 'package:aniwatch/watch_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class AnimeInfo extends StatefulWidget {
  final String title;
  final int id;

  const AnimeInfo({super.key, required this.title, required this.id});

  @override
  State<AnimeInfo> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends State<AnimeInfo> {
  late Future<AnilistInfo?> futureInfo;

  @override
  void initState() {
    super.initState();
    futureInfo = AnilistMeta().getInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeData.dark().primaryColorDark,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<AnilistInfo?>(
          future: futureInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 6,
                    child: Image.network(
                      snapshot.data!.cover!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parseFragment(snapshot.data?.description).text ??
                              "Not available",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.tv, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              '${snapshot.data!.totalEpisodes!} episodes',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 32),
                            Icon(Icons.star,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.data!.rating.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 32),
                            Icon(Icons.home_max,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.data?.studios?.join(", ") ??
                                  "Not Available",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: snapshot.data!.episodes!.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: 0.5,
                                image: NetworkImage(e.image!),
                                fit: BoxFit.cover)),
                        child: ListTile(
                          onTap: () => Get.to(() => Watch(
                                episode: e,
                                anime: snapshot.data!,
                                //episodeNumber: e.number
                              )),
                          title: Text(
                            'Episode ${e.number}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            e.title ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
