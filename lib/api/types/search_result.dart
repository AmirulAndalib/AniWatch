import 'package:aniwatch/api/types/Popular.dart';

class SearchResult {
  SearchResult({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });
  late final int currentPage;
  late final bool hasNextPage;
  late final List<Result> results;

  SearchResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    hasNextPage = json['hasNextPage'];
    results =
        List.from(json['results']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currentPage'] = currentPage;
    _data['hasNextPage'] = hasNextPage;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}
