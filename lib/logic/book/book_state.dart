import 'package:jaksmok_fe/data/models/book_list_model.dart';

abstract class BookState {}

class BookInit extends BookState {}

class BookLoading extends BookState {}

class BooksListSuccess extends BookState {
  final List<Book> books;
  final bool hasMore;

  BooksListSuccess({required this.books, required this.hasMore});
}

class BookSuccess extends BookState {
  final Book book;
  BookSuccess({required this.book});
}

class BookError extends BookState {
  final String error;
  final Object fullError;
  BookError({required this.error, required this.fullError});
}
