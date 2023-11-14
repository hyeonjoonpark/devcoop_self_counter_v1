import 'package:counter/state/home/home_getx.dart';
import 'package:counter/state/payments/payments_getx.dart';
import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/payments/widgets/payments_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<PaymentsGetx>(builder: (x) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 90,
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${HomeGetx.to.user?.studentName} 학생  |  잔액 ${HomeGetx.to.user?.point}원',
                style: DevCoopTextStyle.bold_40.copyWith(
                  color: DevCoopColors.black,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                color: Colors.black,
                thickness: 4,
                height: 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      paymentsItem(
                        left: '상품 이름',
                        center: '수량',
                        rightText: '상품 가격',
                        contentsTitle: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < 15; i++) ...[
                                paymentsItem(
                                  left: '슈퍼콘 민트초코 $i',
                                  center: '1',
                                  right: 1400,
                                  totalText: false,
                                ),
                                if (i < 14) ...[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 4,
                height: 4,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                      ),
                      child: paymentsItem(
                        left: '총 상품 개수 및 합계',
                        center: '1',
                        right: 1400,
                      ),
                    ),
                    mainTextButton(
                      text: '계산하기',
                      onTap: () {
                        x.payment(
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
