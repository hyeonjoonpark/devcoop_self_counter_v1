import 'package:flutter/material.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';

void main() {
  runApp(MaterialApp(home: MyHome()));
}

class MyHome extends StatefulWidget {
  MyHome();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 600), // 사용자 지정 단위로 마진 설정
              child: const Text(
                'touch to start',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: DevCoopColors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
