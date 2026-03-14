import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jaksmok_fe/core/localization/locale_keys.g.dart';
import 'package:jaksmok_fe/core/network/error/failure.dart';
import 'package:jaksmok_fe/features/book/data/datasources/book_remote_datasource.dart';
import 'package:jaksmok_fe/features/book/data/models/book_model.dart';
import 'package:jaksmok_fe/features/book/data/models/book_model_mapper.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';
import 'package:jaksmok_fe/features/book/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource bookRemoteDatasource;

  BookRepositoryImpl(this.bookRemoteDatasource);

  @override
  Future<Either<Failure, BookListEntity>> getBooks(int? size, int? page) async {
    try {
      final response = await bookRemoteDatasource.getBooks(size, page);
      final fromJson = BookListModel.fromJson(response);
      final toEntity = fromJson.toEntity();
      return Right(toEntity);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> getBooksById(int id) async {
    try {
      final response = await bookRemoteDatasource.getBooksById(id);
      final fromJson = BookModel.fromJson(response);
      final toEntity = fromJson.toEntity();
      return Right(toEntity);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(Failure(LocaleKeys.errors_book_not_found));
      }
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
