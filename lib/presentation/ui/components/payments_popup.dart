import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/utils/self_counter_button.dart';
import 'package:flutter/material.dart';
import 'package:counter/presentation/ui/view/main_page.dart';

Widget paymentsPopUp(BuildContext context) {
  return Center(
      child: AlertDialog(
        title: Text('1400원을 결제할게요'),
        content: Container(
          width: 520,
          height: 320,
          child: Text(
            "잠시후에 처음화면으로 돌아갑니다",
            style: TextStyle(
              color: DevCoopColors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          CounterElevatedButton(
            text: "닫기",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  MyHome(),
                ),
              );
            },
            buttonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(DevCoopColors.primary),
              alignment: Alignment.center,
            ),
            textStyle: TextStyle(
              color: DevCoopColors.black,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
        ],
      ),
  );
}