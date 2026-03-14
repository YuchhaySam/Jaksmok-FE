import 'package:dartz/dartz.dart';
import 'package:jaksmok_fe/core/network/error/failure.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, BookListEntity>> getBooks(int? size, int? page);
  Future<Either<Failure, BookEntity>> getBooksById(int id);
}
