import 'package:counter/ui/barcode/barcode_page.dart';
import 'package:counter/ui/check/check_student.dart';
import 'package:counter/ui/home/home_page.dart';
import 'package:counter/ui/payments/payments_page.dart';
import 'package:counter/ui/pin/pin_page.dart';
import 'package:get/get.dart';

List<GetPage> AppRouter = [
  GetPage(
    name: '/',
    page: () => MyHome(),
  ),
  GetPage(
    name: "/barcode",
    page: () => BarcodePage(),
  ),
  GetPage(
    name: "/check",
    page: () => CheckStudent(),
  ),
  GetPage(
    name: "/payments",
    page: () => PaymentsPage(),
  ),
  GetPage(
    name: "/pin",
    page: () => PinPage(
      codeNumber: Get.arguments as String,
    ),
  ),
];
