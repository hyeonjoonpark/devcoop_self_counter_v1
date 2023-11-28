import 'dart:convert';

import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter/controller/save_user_info.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  final TextEditingController _codeNumberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _barcodeFocus = FocusNode();
  TextEditingController? _activeController;

  @override
  Widget build(BuildContext context) {
    // 변경: 바코드 입력 창이 포커싱되지 않도록 수정
    if (_activeController != _codeNumberController) {
      FocusScope.of(context).requestFocus(_barcodeFocus);
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 30,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int j = 0; j < 3; j++) ...[
                              GestureDetector(
                                onTap: () {
                                  int _number = j + 1 + i * 3;
                                  onNumberButtonPressed(
                                      _number == 11 ? 0 : _number);
                                },
                                child: Container(
                                  width: 95,
                                  height: 95,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: (j + 1 + i * 3 == 10 ||
                                            j + 1 + i * 3 == 12)
                                        ? DevCoopColors.primary
                                        : const Color(0xFFD9D9D9),
                                  ),
                                  child: Text(
                                    '${j + 1 + i * 3 == 10 ? 'Clear' : (j + 1 + i * 3 == 11 ? '0' : (j + 1 + i * 3 == 12 ? 'Del' : j + 1 + i * 3))}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: DevCoopColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (i < 3) ...[
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ],
                    ],
                  ),
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
                            child: GestureDetector(
                              onTap: () {
                                _setActiveController(_codeNumberController);
                              },
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
                                child: TextField(
                                  controller: _codeNumberController,
                                  focusNode: _barcodeFocus,
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
                            child: GestureDetector(
                              onTap: () {
                                _setActiveController(_pinController);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 34,
                                  horizontal: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECECEC),
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: TextField(
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
                                  obscureText: true,
                                ),
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
              height: 128,
            ),
            Row(
              children: [
                Container(margin: EdgeInsets.only(left: 240)),
                mainTextButton(
                  text: '처음으로',
                  onTap: () {
                    Get.toNamed('/home');
                  },
                ),
                const SizedBox(
                  width: 560,
                ),
                mainTextButton(
                  text: '확인',
                  onTap: () {
                    _login(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onNumberButtonPressed(int number) {
    if (_activeController != null) {
      String currentText = _activeController!.text;

      if (number == 10) {
        _activeController!.clear(); // Clear focus and text
      } else if (number == 12) {
        // Del button
        if (currentText.isNotEmpty) {
          String newText = currentText.substring(0, currentText.length - 1);
          _activeController!.text = newText;
        }
      } else {
        String newText = currentText + (number == 11 ? '0' : number.toString());
        _activeController!.text = newText;
      }
    }
  }

  void _setActiveController(TextEditingController controller) {
    setState(() {
      _activeController = controller;
    });
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
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        String codeNumber = responseBody['user']['codeNumber'];
        String pin = responseBody['user']['pin'];
        int point = responseBody['user']['point'];
        String studentName = responseBody['user']['studentName'];
        int userId = responseBody['user']['studentNumber'];

        saveUserData(codeNumber, pin, point, studentName, userId);
        print("저장성공");

        Get.toNamed('/check');
      }
    } catch (e) {
      print(e);
    }
  }
}
