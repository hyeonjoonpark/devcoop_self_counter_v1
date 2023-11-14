import 'package:counter/ui/barcode/barcode_page.dart';
import 'package:counter/ui/check/check_page.dart';
import 'package:counter/ui/home/home_page.dart';
import 'package:counter/ui/payments/payments_page.dart';
import 'package:get/get.dart';

List<GetPage> AppRouter = [
  GetPage(
    name: '/',
    page: () => const MyHome(),
  ),

  GetPage(
    name: "/barcode",
    page: () => const BarcodePage(),
  ),

  GetPage(
    name: "/check",
    page: () => const CheckPage(),
  ),

  GetPage(
    name: "/payments",
    page: () =>  PaymentsPage(),
  ),

];
