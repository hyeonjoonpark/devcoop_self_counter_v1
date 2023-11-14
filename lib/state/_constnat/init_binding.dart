import 'package:counter/state/home/home_getx.dart';
import 'package:counter/state/payments/payments_getx.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeGetx());
    Get.put(PaymentsGetx());
  }
}
