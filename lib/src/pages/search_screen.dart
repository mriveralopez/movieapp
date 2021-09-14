import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flappy_search_bar_ns/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/l10n.dart';
import 'package:movie/src/controllers/search_controller.dart';
import 'package:movie/src/models/movie.dart';
import 'package:movie/src/models/search.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends StateMVC<SearchScreen> {
  late SearchController _con;
  late Size _size;

  _SearchScreenState() : super(SearchController()) {
    _con = controller as SearchController;
  }

  @override
  void initState() {
    _con.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _con.scaffoldKey,
      body: SafeArea(
        child: Container(
          child: SearchBar<Movie>(
            searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
            headerPadding: EdgeInsets.symmetric(horizontal: 10),
            listPadding: EdgeInsets.symmetric(horizontal: 10),
            onSearch: (search) async {
              Search searchResponse = await _con.listenSearch(context, search);
              return searchResponse.search ?? [];
            },
            searchBarController: _con.searchBarController,
            hintStyle: TextStyle(),
            hintText: S.of(context).search,
            textStyle: TextStyle(),
            onError: (error) => Text('ERROR: ${error.toString()}'),
            placeHolder: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
                children: _con.search!.search!
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/Movie', arguments: e.imdbId!);
                        },
                        child: Container(
                          width: _size.width * 0.25,
                          child: Image.network(
                            e.poster!,
                            width: _size.width * 0.25,
                            fit: BoxFit.cover,
                            scale: 16 / 9,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            cancellationWidget: Text(S.of(context).cancel),
            emptyWidget: Text(S.of(context).empty),
            header: Row(
              children: <Widget>[
                TextButton(
                  child: Text(
                    S.of(context).sort,
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    _con.searchBarController.sortList(
                      (Movie a, Movie b) {
                        return a.title!.compareTo(b.title!);
                      },
                    );
                  },
                ),
                TextButton(
                  child: Text(S.of(context).desort),
                  onPressed: () {
                    _con.searchBarController.removeSort();
                  },
                ),
                TextButton(
                  child: Text(S.of(context).replay),
                  onPressed: () {
                    _con.isReplay = !_con.isReplay;
                    _con.searchBarController.replayLastSearch();
                  },
                ),
              ],
            ),
            onCancelled: () {},
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            suggestions: _con.search?.search ?? [],
            buildSuggestion: (Movie? movie, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/Movie', arguments: movie!.imdbId!);
                },
                child: Container(
                  width: _size.width * 0.25,
                  child: Image.network(
                    movie!.poster!,
                    width: _size.width * 0.25,
                    fit: BoxFit.cover,
                    scale: 16 / 9,
                  ),
                ),
              );
            },
            onItemFound: (Movie? movie, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/Movie', arguments: movie!.imdbId!)
                      .then((value) {
                    _con.getFavorites();
                  });
                },
                child: Container(
                  width: _size.width * 0.25,
                  child: Image.network(
                    movie!.poster!,
                    width: _size.width * 0.25,
                    fit: BoxFit.cover,
                    scale: 16 / 9,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
