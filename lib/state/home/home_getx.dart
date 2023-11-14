import 'package:counter/model/failure/failure.dart';
import 'package:counter/model/user/user_data.dart';
import 'package:counter/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class HomeGetx extends GetxController {
  static HomeGetx get to => Get.find<HomeGetx>();
  final AuthRepository _authRepository = AuthRepository();

  bool isEvent = false;
  UserData? user;

  Future checkBarcode() async {
    user = UserData(
      codeNumber: '0000',
      pin: '0000',
      point: 123,
      studentName: '이예흔',
    );
    update();
    Get.toNamed('/check');
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () => Get.toNamed(
        '/payments',
      ),
    );
    // 중복 호출 방지
    // if (!isEvent) {
    //   isEvent = true;
    //   update();
    //   Either<Failure, UserData> _successOrFailure =
    //       await _authRepository.login();
    //   _successOrFailure.fold(
    //     (l) {
    //       // 에러 예외 처리 하기
    //       l.map(
    //         networkError: (e) => print(e),
    //         apiError: (e) => print(e),
    //       );
    //       isEvent = false;
    //       update();
    //     },
    //     (r) {
    //       user = r;
    //       isEvent = false;
    //       update();
    //       Get.toNamed('/check');
    //       Future.delayed(
    //         const Duration(
    //           seconds: 3,
    //         ),
    //         () => Get.toNamed(
    //           '/payments',
    //         ),
    //       );
    //     },
    //   );
    // }
  }
}
