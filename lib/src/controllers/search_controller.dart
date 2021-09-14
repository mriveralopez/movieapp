import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/models/movie.dart';
import 'package:movie/src/models/search.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/search_repository.dart' as repository;

class SearchController extends ControllerMVC {
  Search? search = Search(
    search: [],
  );
  GlobalKey<ScaffoldState>? scaffoldKey;

  final SearchBarController<Movie> searchBarController = SearchBarController();
  bool isReplay = false;

  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<Search> listenSearch(BuildContext context, String? search) async {
    Search searchResponse = new Search(
      search: [],
    );
    await repository.listenSearch(context, search).then(
      (value) {
        searchResponse = value;
      },
    );
    return searchResponse;
  }

  getFavorites() async {
    search = await repository.getFavorites();
    setState(() {});
  }
}
