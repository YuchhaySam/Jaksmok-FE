import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaksmok_fe/services/api_service.dart';

class AuthRepository {
  final _storage = const FlutterSecureStorage();
  final ApiService apiService;
  static const _tokenKey = 'auth_token';

  AuthRepository({required this.apiService});

  Future<void> initalizeAuth() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      apiService.updateToken(token);
      return;
    }
    try {
      await apiService.getBooks(1, 1);
    } catch (_) {
      apiService.updateToken(null);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final token = await apiService.login(username, password);
      await _storage.write(key: _tokenKey, value: token);
      apiService.updateToken(token);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> getToken() async => await _storage.read(key: _tokenKey);

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    apiService.updateToken(null);
  }
}
