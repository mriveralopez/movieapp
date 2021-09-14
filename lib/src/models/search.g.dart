// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    response: json['Response'] as String?,
    search: (json['Search'] as List<dynamic>?)
        ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalResults: json['totalResults'] as String?,
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'Response': instance.response,
      'Search': instance.search,
      'totalResults': instance.totalResults,
    };
