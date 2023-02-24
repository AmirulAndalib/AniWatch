import 'package:aniwatch/Trending.dart';
import 'package:aniwatch/consts.dart';
import 'package:aniwatch/popular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'api/types/search_result.dart';
import 'search.dart';

void main() {
  runApp(const GetMaterialApp(home: AniWatch()));
}

class AniWatch extends StatelessWidget {
  const AniWatch({super.key});

  static const String _title = 'AniWatch';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const MyStatefulWidget(),
      theme:
          ThemeData(useMaterial3: true, colorScheme: const ColorScheme.dark()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  late Future<SearchResult?>? futureSearchResult = null;
  String searchValue = '';
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Popular(),
    Trending(),
    Search()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: EasySearchBar(
      //     searchBackIconTheme: const IconThemeData(color: Colors.white),
      //     iconTheme: const IconThemeData(color: Colors.white),
      //     title: const Text('AniWatch'),
      //     onSearch: (value) => setState(() {
      //           if (value.isNotEmpty) {
      //             futureSearchResult = AnilistMeta().searchAnime(value);
      //           }
      //           searchValue = value;
      //         })),
      // drawer: Drawer(
      //     child: FutureBuilder<SearchResult?>(
      //   future: futureSearchResult,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView(
      //           padding: EdgeInsets.zero,
      //           children: snapshot.data!.results.map((e) {
      //             return ListTile(
      //                 title: Text(e.title.english!),
      //                 onTap: () => Get.to(() => AnimeInfo(
      //                     title: e.title.english!, id: int.parse(e.id))));
      //           }).toList());
      //     } else if (snapshot.hasError) {
      //       return Text('${snapshot.error}');
      //     }
      //     return const CircularProgressIndicator();
      //   },
      // )),
      appBar: AppBar(
        title: const Text(APP_NAME),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 209, 21, 216),
        onTap: _onItemTapped,
      ),
    );
  }
}
