import 'package:json_annotation/json_annotation.dart';
import 'package:movie/src/models/rating.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: "Actors")
  String? actors;
  @JsonKey(name: "Awards")
  String? awards;
  @JsonKey(name: "Country")
  String? country;
  @JsonKey(name: "Director")
  String? director;
  @JsonKey(name: "Genre")
  String? genre;
  @JsonKey(name: "imdbID")
  String? imdbId;
  @JsonKey(name: "imdbVotes")
  String? imdbVotes;
  @JsonKey(name: "Language")
  String? language;
  @JsonKey(name: "Metascore")
  String? metascore;
  @JsonKey(name: "Plot")
  String? plot;
  @JsonKey(name: "Poster")
  String? poster;
  @JsonKey(name: "Rated")
  String? rated;
  @JsonKey(name: "Rating")
  List<Rating>? rating;
  @JsonKey(name: "Released")
  String? released;
  @JsonKey(name: "Response")
  String? response;
  @JsonKey(name: "Runtime")
  String? runtime;
  @JsonKey(name: "Title")
  String? title;
  @JsonKey(name: "totalSeasons")
  String? totalSeasons;
  @JsonKey(name: "Type")
  String? type;
  @JsonKey(name: "Writer")
  String? writer;
  @JsonKey(name: "Year")
  String? year;

  Movie({
    this.actors,
    this.awards,
    this.country,
    this.director,
    this.genre,
    this.imdbId,
    this.imdbVotes,
    this.language,
    this.metascore,
    this.plot,
    this.poster,
    this.rated,
    this.rating,
    this.released,
    this.response,
    this.runtime,
    this.title,
    this.totalSeasons,
    this.type,
    this.writer,
    this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
