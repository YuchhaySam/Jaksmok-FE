import 'package:jaksmok_fe/features/book/data/models/book_model.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';

extension BookMapper on BookModel {
  BookEntity toEntity() => BookEntity(
    id: id,
    title: title,
    author: author,
    realYears: realYears,
    year: year,
    country: country,
    language: language,
    pages: pages,
    wikipediaLink: wikipediaLink,
    imageUrl: imageUrl,
  );
}

extension BookListMapper on BookListModel {
  BookListEntity toEntity() => BookListEntity(
    size: size,
    page: page,
    totalPages: totalPages,
    totalBooks: totalElements,
    books: content.map((model) => model.toEntity()).toList(),
  );
}
