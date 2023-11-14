import 'package:counter/state/home/home_getx.dart';
import 'package:counter/state/payments/payments_getx.dart';
import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:flutter/material.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BarcodePage extends StatelessWidget {
  const BarcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeGetx>(
        builder: (x) {
        return Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 90,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "학생증의 바코드를\n리더기로 스캔해주세요.",
                  style: DevCoopTextStyle.bold_40.copyWith(
                    color: DevCoopColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          for (int i = 0; i < 4; i++) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                for (int j = 0; j < 3; j++) ...[
                                  if (i != 3 && (j != 0 || j != 2) ||
                                      (i == 3 && j == 1)) ...[
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 95,
                                        height: 95,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Color(0xFFD9D9D9),
                                        ),
                                        child: Text(
                                          '${i != 3 ? (j + 1) + (i * 3) : 0}',
                                          style: DevCoopTextStyle.light_40.copyWith(
                                            color: DevCoopColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      width: 95,
                                      height: 95,
                                    ),
                                  ],
                                  if (j < 2) ...[
                                    const SizedBox(
                                      width: 47,
                                    )
                                  ]
                                ],
                              ],
                            ),
                            if (i < 3) ...[
                              const SizedBox(
                                height: 52,
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text(
                                  '학생증 번호',
                                  style: DevCoopTextStyle.medium_30.copyWith(
                                    color: DevCoopColors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 34,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECECEC),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(
                                          '[0-9]',
                                        ),
                                      ),
                                    ],
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      hintText: '학생증을 리더기에 스캔해주세요',
                                      hintStyle: DevCoopTextStyle.medium_30.copyWith(
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,

                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 160,
                                alignment: Alignment.center,
                                child: Text(
                                  '핀 번호',
                                  style: DevCoopTextStyle.medium_30.copyWith(
                                    color: DevCoopColors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 34,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFECECEC),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(
                                          '[0-9]',
                                        ),
                                      ),
                                    ],
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      hintText: '자신의 핀번호를 입력해주세요',
                                      hintStyle: DevCoopTextStyle.medium_30.copyWith(
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,

                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                mainTextButton(
                  text: '확인',
                  onTap: () {
                    x.checkBarcode();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
