import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/models/movie.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/search_repository.dart' as repository;

class MovieController extends ControllerMVC {
  Movie movie = Movie();
  GlobalKey<ScaffoldState>? scaffoldKey;
  bool isFavorite = false;

  final SearchBarController<Movie> searchBarController = SearchBarController();
  bool isReplay = false;

  MovieController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenSearchByIdOrTitle(
    BuildContext context, {
    String? id,
    String? title,
  }) async {
    await repository.listenSearchByIdOrTitle(context, id, title).then(
      (value) {
        movie = value;
        loadFavorites();
      },
    );
  }

  addFavorite() async {
    await repository.addFavorites(movie);
    loadFavorites();
  }

  loadFavorites() async {
    isFavorite = await repository.isFavorite(movie);
    setState(() {});
  }

  removeFavorite() async {
    await repository.removeFavorites(movie);
    loadFavorites();
  }
}
