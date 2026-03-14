import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
abstract class BookListModel with _$BookListModel {
  const factory BookListModel({
    required int totalElements,
    required List<BookModel> content,
    required int size,
    required int page,
    required int totalPages,
  }) = _BookListModel;

  factory BookListModel.fromJson(Map<String, dynamic> json) =>
      _$BookListModelFromJson(json);
}

@freezed
abstract class BookModel with _$BookModel {
  const factory BookModel({
    required int id,
    required String title,
    required String author,
    required String realYears,
    required String year,
    required String country,
    required String language,
    required int pages,
    required String wikipediaLink,
    required String imageUrl,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}
