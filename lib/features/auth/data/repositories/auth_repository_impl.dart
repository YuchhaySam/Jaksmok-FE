import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaksmok_fe/core/network/error/failure.dart';
import 'package:jaksmok_fe/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:jaksmok_fe/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final FlutterSecureStorage storage;
  final String _tokenKey = 'auth_token';

  AuthRepositoryImpl(this.authRemoteDatasource, this.storage);

  @override
  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      final token = await authRemoteDatasource.login(username, password);
      await storage.write(key: _tokenKey, value: token);
      return Right(true);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: _tokenKey);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }
}
