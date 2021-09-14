import 'package:flutter/material.dart';
import 'package:movie/generated/l10n.dart';
import 'package:movie/src/controllers/movie_controller.dart';
import 'package:movie/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MovieScreen extends StatefulWidget {
  dynamic imdbID;
  RouteArgument? routeArgument;

  MovieScreen({
    Key? key,
    required this.imdbID,
  }) {
    if (imdbID != null) {
      if (imdbID is RouteArgument) {
        routeArgument = imdbID;
        imdbID = int.parse(imdbID.id);
      }
    } else {
      imdbID = 0;
    }
  }

  @override
  _MovieScreenState createState() => new _MovieScreenState();
}

class _MovieScreenState extends StateMVC<MovieScreen> {
  late MovieController _con;
  late Size _size;

  _MovieScreenState() : super(MovieController()) {
    _con = controller as MovieController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenSearchByIdOrTitle(
      context,
      id: widget.imdbID,
      title: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        title: Text(_con.movie.title ?? ""),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _con.isFavorite ? _con.removeFavorite() : _con.addFavorite();
              // _con.remove();
            },
            icon: Icon(
              _con.isFavorite ? Icons.favorite : Icons.favorite_outline,
              // color: _con.isFavorite ? Colors.white : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          width: _size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _con.movie.poster == null
                  ? CircularProgressIndicator()
                  : Image.network(_con.movie.poster!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_con.movie.year ?? ""),
                  Text(_con.movie.runtime ?? ""),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                _con.movie.plot ?? "",
                style: TextStyle(),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Text(S.of(context).genre + (_con.movie.genre ?? "")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
