import 'package:counter/state/_constnat/init_binding.dart';
import 'package:counter/ui/_constant/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BSM SelfCounter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitBinding(),
      getPages: AppRouter,
      initialRoute: '/',
    );
  }
}
