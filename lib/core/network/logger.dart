import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      "REQ: ${options.method} [${options.path}]\n"
      "Payload: ${options.data}\n"
      "Headers: ${options.headers}",
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      "RES: ${response.statusCode} [${response.requestOptions.path}]\n"
      "Body: ${response.data}",
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      "ERR: ${err.response?.statusCode} [${err.requestOptions.path}]\n"
      "Message: ${err.message}",
    );
    return super.onError(err, handler);
  }
}
