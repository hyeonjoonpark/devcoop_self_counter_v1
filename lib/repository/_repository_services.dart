import 'package:counter/model/failure/failure.dart';

class RepositoryServices {
  static final RepositoryServices instance = RepositoryServices._internal();
  RepositoryServices._internal();
  factory RepositoryServices() => instance;

  Failure handler({
    Object? exception,
  }) {
    if (exception != null) {
      print("ExceptionError Error :: ${exception}");
      return Failure.apiError();
    } else {
      print("Unknown Error :: ${exception}");
      return Failure.apiError();
    }
  }
}
