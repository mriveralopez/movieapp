import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  @JsonKey(name: "Response")
  String? response;
  @JsonKey(name: "Search")
  List<Movie>? search;
  @JsonKey(name: "totalResults")
  String? totalResults;

  Search({
    this.response,
    this.search,
    this.totalResults,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
