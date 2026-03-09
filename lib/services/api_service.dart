import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  String? _authToken;

  //Define baseUrl
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://assignment-be.jaksmok.com/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          //Insert _authToken to authorization header
          if (_authToken != null) {
            options.headers['authorization'] = 'Basic $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          final bool isSilent = error.requestOptions.extra['silent'] ?? false;
          if (isSilent &&
              (error.response?.statusCode == 401 ||
                  error.response?.statusCode == 403)) {
            return handler.resolve(error.response!);
          }
          return handler.next(error);
        },
      ),
    );
  }

  void updateToken(String? token) {
    _authToken = token;
  }

  Future<T> _requestWrapper<T>(Future<Response> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Not found');
      }

      if (e.response?.statusCode == 500) {
        throw Exception('Internal server error');
      }

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      rethrow;
    }
  }

  Future<String> login(String username, String password) async {
    final encoded = base64Encode(utf8.encode('$username:$password'));
    await _requestWrapper(() {
      return _dio.get(
        '/books',
        options: Options(
          headers: {'authorization': 'Basic $encoded'},
          extra: {'silent': true},
        ),
      );
    });
    return encoded;
  }

  Future<Map<String, dynamic>> getBooks(int? size, int? page) async {
    final response = await _requestWrapper(() {
      return _dio.get(
        '/books',
        queryParameters: {
          if (size != null) 'size': size,
          if (page != null) 'page': page,
        },
      );
    });
    return response;
  }

  Future<Map<String, dynamic>> getBookById(int id) async {
    final response = await _requestWrapper(() => _dio.get('/books/$id'));
    return response;
  }
}
