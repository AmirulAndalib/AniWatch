// ignore_for_file: library_prefixes, use_build_context_synchronously
import 'package:aniwatch/animeInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart';

import 'helpers/popUp.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final db = Localstore.instance;
  late Future<Map<String, dynamic>?> futureFavs;

  @override
  void initState() {
    super.initState();
    futureFavs = db.collection('favs').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: futureFavs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var animes = snapshot.data!.values.toList(growable: true);
              snapshot.data!.keys.map((e) => debugPrint(e));
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: animes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => AnimeInfo(
                          title: animes[index]['anime_name'],
                          id: int.parse(animes[index]['anime_id']))),
                      onLongPress: () async {
                        setState(() {});
                        ShowToast(context,
                            "Removed ${animes[index]['anime_name']} from favorites");
                        await db
                            .collection('favs')
                            .doc(animes[index]["anime_id"])
                            .delete();
                      },
                      child: ListTile(
                        title: Text(animes[index]["anime_name"]),
                        subtitle: Text(animes[index]["anime_id"]),
                        leading: SizedBox(
                            child: Image.network(animes[index]["anime_img"])),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.isBlank == true) {
              return const Text(
                  "Nothing added to favorites, long press on an anime tile to add to favorites");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
