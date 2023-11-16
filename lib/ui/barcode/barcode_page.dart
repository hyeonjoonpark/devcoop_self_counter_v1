import 'dart:convert';

import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter/controller/save_user_info.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../check/check_student.dart';

class BarcodePage extends StatelessWidget {
  const BarcodePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _codeNumberController = TextEditingController();
    final TextEditingController _pinController = TextEditingController();

    void onNumberButtonPressed(int number) {
      String currentText = _codeNumberController.text;
      String newText = '$currentText$number';
      _codeNumberController.text = newText;
    }

    Future<void> _login(BuildContext context) async {
      String codeNumber = _codeNumberController.text;
      String pin = _pinController.text;

      Map<String, String> requestBody = {'codeNumber': codeNumber, 'pin': pin};
      String jsonData = json.encode(requestBody);

      String apiUrl = 'http://localhost:8080/kiosk/auth/signIn';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          print("로그인 성공");

          Map<String, dynamic> responseBody =
              jsonDecode(utf8.decode(response.bodyBytes))
                  as Map<String, dynamic>;

          String codeNumber = responseBody['data']['user']['codeNumber'];
          String pin = responseBody['data']['user']['pin'];
          int point = responseBody['data']['user']['point'];
          String studentName = responseBody['data']['user']['studentName'];

          saveUserData(codeNumber, pin, point, studentName);
          print("저장성공");

          Get.toNamed('/check');
        }
      } catch (e) {
        print(e);
      }
    }

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
                                  onTap: () {
                                    onNumberButtonPressed((j + 1) + (i * 3));
                                  },
                                  child: Container(
                                    width: 95,
                                    height: 95,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: const Color(0xFFD9D9D9),
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
                                controller: _codeNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      '[0-9]',
                                    ),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintText: '학생증을 리더기에 스캔해주세요',
                                  hintStyle: DevCoopTextStyle.medium_30
                                      .copyWith(fontSize: 15),
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
                                controller: _pinController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      '[0-9]',
                                    ),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintText: '자신의 핀번호를 입력해주세요',
                                  hintStyle:
                                      DevCoopTextStyle.medium_30.copyWith(
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
              height: 30,
            ),
            mainTextButton(
              text: '확인',
              onTap: () {
                _login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
