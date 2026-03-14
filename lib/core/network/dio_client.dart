import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaksmok_fe/core/network/interceptor/auth_interceptor.dart';
import 'package:jaksmok_fe/core/network/interceptor/error_interceptor.dart';
import 'package:jaksmok_fe/core/network/session/session_manager.dart';
import 'package:jaksmok_fe/core/network/logger.dart';

class DioClient {
  final FlutterSecureStorage storage;
  final SessionManager sessionManager;
  final Dio dio;

  DioClient(this.storage, this.sessionManager)
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://assignment-be.jaksmok.com/api/v1',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    dio.interceptors.addAll([
      AuthInterceptor(storage),
      ErrorInterceptor(sessionManager),
      LoggingInterceptor(),
    ]);
  }
}
