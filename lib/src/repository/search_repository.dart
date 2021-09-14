import 'dart:convert';

import 'package:movie/src/models/movie.dart';
import 'package:movie/src/models/search.dart';
import 'package:movie/src/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Search> listenSearch(context, String? search) async {
  Search searchResponse = Search();
  await Provider.of<ApiService>(
    context,
    listen: false,
  )
      .getSearch(
    search: search,
  )
      .then(
    (value) {
      searchResponse = value;
    },
  );
  return searchResponse;
}

Future<Movie> listenSearchByIdOrTitle(
    context, String? id, String? title) async {
  Movie movieResponse = Movie();
  await Provider.of<ApiService>(
    context,
    listen: false,
  )
      .getSearchByIdOrTitle(
    id: id,
    title: title,
  )
      .then(
    (value) {
      movieResponse = value;
    },
  );
  return movieResponse;
}

addFavorites(Movie movie) async {
  Search search = Search(
    search: [],
    response: "",
    totalResults: "",
  );

  bool exist = false;

  search = await getFavorites();
  if (search.search != null) {
    for (int i = 0; i < search.search!.length; i++) {
      if (search.search![i].imdbId == movie.imdbId) {
        exist = true;
      }
    }
  }
  if (!exist) {
    search.search!.add(movie);
  }

  setFavorites(search);
}

removeFavorites(Movie movie) async {
  Search search = Search(search: []);

  search = await getFavorites();
  if (search.search != null) {
    for (int i = 0; i < search.search!.length; i++) {
      if (search.search![i].imdbId == movie.imdbId) {
        search.search!.removeAt(i);
      }
    }
  }

  setFavorites(search);
}

Future<bool> isFavorite(Movie movie) async {
  Search search = Search(search: []);

  search = await getFavorites();

  for (Movie mov in search.search!) {
    if (mov.imdbId == movie.imdbId) {
      return true;
    }
  }

  return false;
}

void setFavorites(Search search) async {
  if (search.toJson() != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', jsonEncode(search));
  }
}

void removeFavorite() async {
  Search search = Search(search: []);
  print(search.toJson());
  if (search.toJson() != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', jsonEncode(search));
  }
}

Future<Search> getFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  Search search = Search(search: []);

  if (prefs.containsKey('favorites')) {
    search = Search.fromJson(jsonDecode(prefs.get('favorites').toString()));
  }

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

  return search;
}
