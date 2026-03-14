import 'package:dartz/dartz.dart';
import 'package:jaksmok_fe/core/network/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String username, String password);
  Future<void> logout();
  Future<String?> getToken();
}
