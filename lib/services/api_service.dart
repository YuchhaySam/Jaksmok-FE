import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jaksmok_fe/models/book_list_model.dart';
import 'package:jaksmok_fe/notifiers/global_notifier.dart';
import 'package:jaksmok_fe/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String? _authToken;
  static ValueNotifier<bool> authNotifier = ValueNotifier(false);

  //Define baseUrl
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://assignment-be.jaksmok.com/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  //The purpose of this initState is to check for an exisiting auth_token
  //which allow the app to direct user to homescreen without the need to login everytime
  //if the token is valid
  static Future<void> init() async {
    //Pull auth_token from SharePreferences and insert into _authToken
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('auth_token');

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
          //Since we don't have a login endpoint, we rely on 'extra': 'silent'
          //this make the logout() method not to excecute if an error is caught
          //at login() method
          final bool isSilent = error.requestOptions.extra['silent'] ?? false;

          //Another purpose of this is to also log the user out, if for example
          //their password changed, and the current token is no longer valid.
          if (!isSilent &&
              (error.response?.statusCode == 401 ||
                  error.response?.statusCode == 403)) {
            await logout();
          }
          handler.next(error);
        },
      ),
    );

    //This validate if the saved token from Share preference is still valid.
    if (_authToken != null) {
      try {
        await _dio.get('/books');
        authNotifier.value = true;
      } catch (error) {
        authNotifier.value = false;
      }
    } else {
      authNotifier.value = false;
    }
  }

  static Future<T> _requestWrapper<T>(
    Future<Response> Function() request,
  ) async {
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
      rethrow;
    }
  }

  static Future<bool> login(String username, String password) async {
    try {
      final encoded = base64Encode(utf8.encode('$username:$password'));
      final response = await _dio.get(
        '/books',
        options: Options(
          headers: {'authorization': 'Basic $encoded'},
          extra: {'silent': true},
        ),
      );
      if (response.statusCode == 200) {
        //We saved the encoded into 'auth_token' to reuse it later.
        _authToken = encoded;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', encoded);
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  static Future<void> logout() async {
    _authToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    authNotifier.value = false;

    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  static Future<BookList> getBooks(int? size, int? page) async {
    final response = await _requestWrapper(() {
      return _dio.get(
        '/books',
        queryParameters: {
          if (size != null) 'size': size,
          if (page != null) 'page': page,
        },
      );
    });
    final data = BookList.fromJson(response);

    return data;
  }

  static Future<Book> getBookById(int id) async {
    final response = await _requestWrapper(() => _dio.get('/books/$id'));
    final data = Book.fromJson(response);
    return data;
  }
}
