// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookListModel _$BookListModelFromJson(Map<String, dynamic> json) =>
    _BookListModel(
      totalElements: (json['totalElements'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: (json['size'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$BookListModelToJson(_BookListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'content': instance.content,
      'size': instance.size,
      'page': instance.page,
      'totalPages': instance.totalPages,
    };

_BookModel _$BookModelFromJson(Map<String, dynamic> json) => _BookModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  author: json['author'] as String,
  realYears: json['realYears'] as String,
  year: json['year'] as String,
  country: json['country'] as String,
  language: json['language'] as String,
  pages: (json['pages'] as num).toInt(),
  wikipediaLink: json['wikipediaLink'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$BookModelToJson(_BookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'realYears': instance.realYears,
      'year': instance.year,
      'country': instance.country,
      'language': instance.language,
      'pages': instance.pages,
      'wikipediaLink': instance.wikipediaLink,
      'imageUrl': instance.imageUrl,
    };
