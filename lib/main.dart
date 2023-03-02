import 'package:aniwatch/Trending.dart';
import 'package:aniwatch/consts.dart';
import 'package:aniwatch/favorites.dart';
import 'package:aniwatch/popular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  static const List<Widget> _widgetOptions = <Widget>[
    Popular(),
    Trending(),
    Search(),
    Favorites(),
    LicensePage(
        applicationName: APP_NAME,
        applicationVersion: "0.0.1-beta",
        applicationLegalese: "Copyright 2023 Sayan Biswas")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        // backgroundColor: ThemeData.dark().primaryColorDark,
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
              indicatorColor: Theme.of(context).appBarTheme.surfaceTintColor,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                    icon: Icon(Icons.people), label: Text('Popular')),
                NavigationRailDestination(
                    icon: Icon(Icons.trending_up), label: Text("Trending")),
                NavigationRailDestination(
                    icon: Icon(Icons.search), label: Text("Search")),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite), label: Text("Favorites")),
                NavigationRailDestination(
                    icon: Icon(Icons.info), label: Text("About"))
              ],
              selectedIndex: _selectedIndex,
              backgroundColor: ThemeData.dark().canvasColor,
              minWidth: 60,
              onDestinationSelected: _onItemTapped),
          // const VerticalDivider(thickness: 1, width: 2),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          )
        ],
      ),
    );
  }
}
