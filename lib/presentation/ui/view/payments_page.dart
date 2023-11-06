import 'package:counter/presentation/ui/components/all_items_count.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/utils/self_counter_button.dart';
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
              margin: const EdgeInsets.only(top: 56),
              child: const Text(
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
              margin: const EdgeInsets.only(top: 32),
              child: const Divider( // Divider 위젯을 사용하여 가로 줄을 그립니다.
                color: Colors.black, // 가로 줄의 색상을 지정할 수 있습니다.
                thickness: 4, // 가로 줄의 두께를 조절할 수 있습니다.
              ),
            ),

            userSelectedItems(context),

            Container(
              width: screenWidth * 0.7,
              margin: const EdgeInsets.only(top: 440),
              child: const Divider( // Divider 위젯을 사용하여 가로 줄을 그립니다.
                color: Colors.black, // 가로 줄의 색상을 지정할 수 있습니다.
                thickness: 4, // 가로 줄의 두께를 조절할 수 있습니다.
              ),
            ),

            allItemsCount(context),

            Container(
              margin: const EdgeInsets.only(left: 856, top: 40),
              child: CounterElevatedButton(
                onPressed: () {

                },
                text: "계산하기",
                buttonStyle: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(DevCoopColors.primary),

                  elevation: MaterialStateProperty.all(0), // 그림자 비활성화

                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0), // 테두리를 둥글게 설정
                  )),

                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: DevCoopColors.primary, // 원하는 테두리 색상 설정
                      width: 2.0, // 테두리 두께 설정
                    ),
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 40,
                  color: DevCoopColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}