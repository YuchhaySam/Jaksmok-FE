import 'package:dio/dio.dart';
import 'package:jaksmok_fe/features/book/data/datasources/book_remote_datasource.dart';

class BookRemoteDatasourceImpl implements BookRemoteDatasource {
  final Dio dio;

  BookRemoteDatasourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getBooks(int? size, int? page) async {
    final response = await dio.get(
      '/books',
      queryParameters: {
        if (size != null) 'size': size,
        if (page != null) 'page': page,
      },
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getBooksById(int id) async {
    final response = await dio.get('/books/$id');
    return response.data;
  }
}
