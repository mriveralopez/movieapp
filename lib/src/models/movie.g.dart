// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    actors: json['Actors'] as String?,
    awards: json['Awards'] as String?,
    country: json['Country'] as String?,
    director: json['Director'] as String?,
    genre: json['Genre'] as String?,
    imdbId: json['imdbID'] as String?,
    imdbVotes: json['imdbVotes'] as String?,
    language: json['Language'] as String?,
    metascore: json['Metascore'] as String?,
    plot: json['Plot'] as String?,
    poster: json['Poster'] as String?,
    rated: json['Rated'] as String?,
    rating: (json['Rating'] as List<dynamic>?)
        ?.map((e) => Rating.fromJson(e as Map<String, dynamic>))
        .toList(),
    released: json['Released'] as String?,
    response: json['Response'] as String?,
    runtime: json['Runtime'] as String?,
    title: json['Title'] as String?,
    totalSeasons: json['totalSeasons'] as String?,
    type: json['Type'] as String?,
    writer: json['Writer'] as String?,
    year: json['Year'] as String?,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'Actors': instance.actors,
      'Awards': instance.awards,
      'Country': instance.country,
      'Director': instance.director,
      'Genre': instance.genre,
      'imdbID': instance.imdbId,
      'imdbVotes': instance.imdbVotes,
      'Language': instance.language,
      'Metascore': instance.metascore,
      'Plot': instance.plot,
      'Poster': instance.poster,
      'Rated': instance.rated,
      'Rating': instance.rating,
      'Released': instance.released,
      'Response': instance.response,
      'Runtime': instance.runtime,
      'Title': instance.title,
      'totalSeasons': instance.totalSeasons,
      'Type': instance.type,
      'Writer': instance.writer,
      'Year': instance.year,
    };
