import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jaksmok_fe/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<String> login(String username, String password) async {
    final encoded = base64Encode(utf8.encode('$username:$password'));
    await dio.get(
      '/books',
      options: Options(
        headers: {'authorization': 'Basic $encoded'},
        extra: {'silent': true},
      ),
    );
    return encoded;
  }
}
