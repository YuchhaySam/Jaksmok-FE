import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jaksmok_fe/core/localization/locale_keys.g.dart';
import 'package:jaksmok_fe/core/network/session/session_manager.dart';

class ErrorInterceptor extends Interceptor {
  final SessionManager sessionManager;

  ErrorInterceptor(this.sessionManager);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isSlient = err.requestOptions.extra['silent'] == true;
    String messageKey = 'errors.global.unknown';

    if (isSlient && err.response?.statusCode == 401) {
      messageKey = LocaleKeys.errors_auth_invalid_credential;
    } else if (err.response?.statusCode == 401) {
      sessionManager.logout();
      messageKey = LocaleKeys.errors_global_unauthorized;
    } else if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      messageKey = LocaleKeys.errors_global_no_internet;
    } else if (err.response!.statusCode! <= 500) {
      messageKey = LocaleKeys.errors_global_server_error;
    }

    final error = err.copyWith(message: messageKey.tr());
    return handler.next(error);
  }
}
