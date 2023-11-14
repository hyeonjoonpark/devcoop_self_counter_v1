import 'package:counter/model/failure/failure.dart';
import 'package:counter/model/user/user_data.dart';
import 'package:counter/repository/_repository_services.dart';
import 'package:counter/state/_constnat/http_sevice.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  static final AuthRepository _repository = AuthRepository._internal();
  factory AuthRepository() => _repository;
  AuthRepository._internal();

  Dio _dio = HttpService().to();

  Future<Either<Failure, UserData>> login({
    // 나중에 required로 바꾸고 함수 사용할 때 데이터 넘기기
    String codeNumber = '2022058',
    String pin = '123456',
  }) async {
    try {
      final _response = await _dio.post('/kiosk/auth/signIn', data: {
        "codeNumber" : codeNumber,
        "pin" : pin,
      });
      if (_response.statusCode == 200) {
        final _fromData = _response.data as Map<String, dynamic>;
        final _result = UserData.fromJson(_fromData);
        return right(_result);
      }
      return left(RepositoryServices.instance.handler());
    } catch (e) {
      return left(RepositoryServices.instance.handler(exception: e));
    }
  }
}
