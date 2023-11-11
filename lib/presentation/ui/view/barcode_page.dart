import 'package:flutter/material.dart';
import 'package:counter/model/barcode_api.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/utils/self_counter_button.dart';

void main() {
  runApp(const MaterialApp(home: BarcodeApp()));
}

class BarcodeApp extends StatelessWidget {
  const BarcodeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Barcode(),
    );
  }
}

class Barcode extends StatefulWidget {
  const Barcode({Key? key}) : super(key: key);

  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "학생 바코드를 스캔해주세요",
                style: TextStyle(
                  fontSize: 30,
                  color: DevCoopColors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/barcode.png',
                width: 300,
                height: 300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: screenHeight * 0.1, bottom: screenHeight * 0.1),
              child: CounterElevatedButton(
                buttonStyle: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor:
                      MaterialStateProperty.all<Color>(DevCoopColors.primary),
                ),
                onPressed: () {
                  print("로그인 버튼 클릭");
                  login(context);
                },
                text: '로그인',
                textStyle: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
