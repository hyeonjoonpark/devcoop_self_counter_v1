import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:flutter/material.dart';

AlertDialog paymentsPopUp(BuildContext context) {
  return AlertDialog(
    content: Container(
      width: 520,
      height: 320,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '1400원을 결제할게요',
            style: DevCoopTextStyle.light_40.copyWith(
              color: DevCoopColors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "잠시후에 처음화면으로 돌아갑니다",
            style: DevCoopTextStyle.medium_30.copyWith(
              color: DevCoopColors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
