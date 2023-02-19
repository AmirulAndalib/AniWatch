import 'package:aniwatch/api/meta.dart';
import 'package:aniwatch/api/types/Trending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animeInfo.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  late Future<AnilistTrending?> futureTrending;
  List<Widget> popularList = [];

  @override
  void initState() {
    super.initState();
    futureTrending = AnilistMeta().getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<AnilistTrending?>(
          future: futureTrending,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: snapshot.data!.results.map((e) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            opacity: 0.5,
                            image: NetworkImage(e.image),
                            fit: BoxFit.cover)),
                    child: ListTile(
                      onTap: () => Get.to(() => AnimeInfo(
                            id: int.parse(e.id),
                            title: e.title.english,
                          )),
                      title: Text(e.title.romaji),
                      subtitle: Text(e.title.english),
                    ),
                  );
                }).toList(),
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
