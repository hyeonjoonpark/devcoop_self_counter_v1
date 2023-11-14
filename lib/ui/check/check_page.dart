import 'package:counter/state/payments/payments_getx.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/util/number_format_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentsGetx>(
      builder: (x) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/accept.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  '1141 이예흔 학생\n${NumberFormatUtil.convert1000Number(3780)} 조회되었습니다.',
                  style: DevCoopTextStyle.bold_40.copyWith(
                    color: DevCoopColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
