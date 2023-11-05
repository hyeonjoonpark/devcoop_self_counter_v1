import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Barcode(),
  ));
}

class Barcode extends StatefulWidget {
  Barcode();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Barcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "학생 바코드를\n 스캔해주세요",
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
                'assets/barcode.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
