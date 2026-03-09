import 'package:jaksmok_fe/data/models/book_list_model.dart';
import 'package:jaksmok_fe/services/api_service.dart';

class BookRepository {
  final ApiService apiService;

  BookRepository({required this.apiService});

  Future<BookList> getBooks(int? size, int? page) async {
    final rawData = await apiService.getBooks(size, page);
    return BookList.fromJson(rawData);
  }

  Future<Book> getBookById(int id) async {
    final rawData = await apiService.getBookById(id);
    return Book.fromJson(rawData);
  }
}
