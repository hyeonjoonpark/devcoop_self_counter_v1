import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CheckStudent(),
  ));
}

class CheckStudent extends StatefulWidget {
  CheckStudent();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CheckStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: const Text(
                "0000 홍길동 학생 \n 잔액 0000원 조회되었습니다",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: DevCoopColors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/accept.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
