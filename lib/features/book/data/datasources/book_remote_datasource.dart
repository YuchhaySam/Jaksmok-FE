abstract class BookRemoteDatasource {
  Future<Map<String, dynamic>> getBooks(int? size, int? page);
  Future<Map<String, dynamic>> getBooksById(int id);
}
