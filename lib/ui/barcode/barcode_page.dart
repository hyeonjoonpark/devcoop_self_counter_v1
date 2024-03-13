import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  final TextEditingController _codeNumberController =
      TextEditingController(text: '');
  final FocusNode _barcodeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // 화면이 나타난 후에 포커스를 지정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_barcodeFocus);
    });
  }

  // @override
  // void dispose() {
  //   _barcodeFocus.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    _barcodeFocus.dispose();
    super.dispose();
  }

  void _setActiveController(TextEditingController controller) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 전체를 가운데 정렬하기 위해 Center 위젯 사용
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로 방향으로 가운데 정렬
            children: [
              Text(
                "학생증의 바코드를\n리더기로 스캔해주세요.",
                style: DevCoopTextStyle.bold_40.copyWith(
                  color: DevCoopColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 160),
              // SvgPicture.asset(
              //   'assets/images/AriPayL_ver2.svg',
              //   width: 150,
              //   height: 150,
              // ),
              const SizedBox(height: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // 가로 방향으로 가운데 정렬
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Row 내부 요소 가운데 정렬
                      children: [
                        Text(
                          '학생증 번호',
                          style: DevCoopTextStyle.medium_30.copyWith(
                            color: DevCoopColors.black,
                          ),
                        ),
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: () {
                            _setActiveController(_codeNumberController);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 500, // Container 가로 크기를 500으로 설정
                            padding: const EdgeInsets.symmetric(
                                vertical: 34, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFFECECEC),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _codeNumberController,
                              focusNode: _barcodeFocus,
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
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Row 내부 요소 가운데 정렬
                      children: [
                        mainTextButton(
                          text: '처음으로',
                          onTap: () {
                            Get.toNamed('/home');
                          },
                        ),
                        const SizedBox(width: 40),
                        mainTextButton(
                          text: '다음으로',
                          onTap: () {
                            Get.toNamed("/pin",
                                arguments: _codeNumberController.text);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
