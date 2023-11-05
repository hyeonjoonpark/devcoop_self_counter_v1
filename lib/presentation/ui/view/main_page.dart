import 'package:flutter/material.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/utils/self_counter_button.dart';
import 'package:counter/presentation/ui/view/barcode_page.dart';

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
              margin: const EdgeInsets.only(top: 600), // 사용자 지정 단위로 마진 설정
              child: CounterElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Barcode(),
                    ),
                  );
                },
                text: "touch to start",
                buttonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(DevCoopColors.white),
                ),
                textStyle: const TextStyle(
                  fontSize: 40,
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
