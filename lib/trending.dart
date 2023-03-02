import 'package:aniwatch/api/meta.dart';
import 'package:aniwatch/api/types/Trending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animeInfo.dart';
import 'helpers/popUp.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  late Future<AnilistTrending?> futureTrending;
  List<Widget> popularList = [];
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

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
              return OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: snapshot.data!.results.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: 0.5,
                                image: NetworkImage(e.image),
                                fit: BoxFit.cover)),
                        child: GestureDetector(
                          onTapDown: (details) => _getTapPosition(details),
                          // show the context menu
                          onLongPress: () => showAnimeContextMenu(
                              context,
                              _tapPosition,
                              e.title.english,
                              e.id,
                              e.image,
                              e.totalEpisodes!),
                          child: ListTile(
                            onTap: () => Get.to(() => AnimeInfo(
                                  id: int.parse(e.id),
                                  title: e.title.english,
                                )),
                            title: Text(e.title.romaji,
                                overflow: TextOverflow.ellipsis),
                            subtitle: Text(e.title.english,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
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
