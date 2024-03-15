import 'package:counter/ui/_constant/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// 뭐임마 뭘하고싶은거야

// 1. 핀 입력페이지에서 숫자누르면 입력이 안되고(수정 완료)
// 2. 결제페이지에서 결제하기 누르면 포스트맨에서는 요청 잘되는데 플러터에서 요청보내면 API 연결이 안되고
// 3. 바코드페이지에서 첫 접속때는 바코드입력이 되는데 두번째부터는 바코드 입력이 안되는

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
