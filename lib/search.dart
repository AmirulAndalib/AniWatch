import 'dart:convert';

import 'package:aniwatch/animeInfo.dart';
import 'package:aniwatch/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> itemList = [];
  List<Map<String, dynamic>> filteredItemList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      final query = searchController.text;
      if (query.isNotEmpty) {
        _getSearchResults(query);
      } else {
        setState(() {
          filteredItemList = [];
        });
      }
    });
  }

  Future<void> _getSearchResults(String query) async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse('$API_ENDPOINT/meta/anilist/$query'));
    final data = jsonDecode(response.body);
    setState(() {
      isLoading = false;
      itemList = List<Map<String, dynamic>>.from(data['results']);
      filteredItemList = itemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: const Text(
            //   "Search Anime on anilist",
            //   // style: TextStyle(fontSize: 28),
            // ),
            flexibleSpace: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(height: 1.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : filteredItemList.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(
                        child: Text('No results found'),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                          filteredItemList.length,
                          (index) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          filteredItemList[index]['image']),
                                      fit: BoxFit.cover,
                                      opacity: 0.5)),
                              child: ListTile(
                                  title: Text(filteredItemList[index]['title']['romaji'] ??
                                      ''),
                                  subtitle: Text(filteredItemList[index]
                                          ['title']['english'] ??
                                      ''),
                                  onTap: () => Get.to(() => AnimeInfo(
                                      title: filteredItemList[index]['title']['romaji'],
                                      id: int.parse(filteredItemList[index]['id']))))),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
