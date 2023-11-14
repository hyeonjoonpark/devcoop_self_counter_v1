import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  static Dio _dio = Dio();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://localhost:8080',
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      // header 설정
      headers: {
        'Authorization': 'Bearer ',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    _dio = Dio(options);
  }

  Dio to() {
    return _dio;
  }
}
