import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:flutter/material.dart';
import 'package:counter/presentation/ui/components/user_selected_items.dart';

void main() {
  runApp(MaterialApp(home: Payments()));
}

class Payments extends StatefulWidget {
  Payments();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 56),
              child: Text(
                "0000 홍길동 학생  |  잔액 0000원",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.7,
              margin: EdgeInsets.only(top: 32),
              child: Divider( // Divider 위젯을 사용하여 가로 줄을 그립니다.
                color: Colors.black, // 가로 줄의 색상을 지정할 수 있습니다.
                thickness: 4, // 가로 줄의 두께를 조절할 수 있습니다.
              ),
            ),

            userSelectedItems(context),
          ],
        ),
      ),
    );
  }
}