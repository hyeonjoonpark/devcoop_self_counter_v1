import 'package:counter/ui/_constant/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: UI/UX 디자인 전체적으로 수정

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BSM SelfCounter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRouter,
      initialRoute: '/',
    );
  }
}
