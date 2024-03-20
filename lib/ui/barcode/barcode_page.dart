import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:counter/ui/_constant/component/button.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/theme/devcoop_colors.dart';

// TODO : 이게 왜 안됨

// 바코드 페이지 에러
// 결제 완료 후 바코드 페이지 재접속 시 바코드 입력이 안되는 현상

// 해결 방법
// 1. 바코드 페이지에 포커스를 재지정하는 코드를 추가합니다.

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> with WidgetsBindingObserver {
  late TextEditingController _codeNumberController;
  final FocusNode _barcodeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  // 바코드페이지에 접속할 때마다 포커스를 재지정합니다.
  @override
  void initState() {
    super.initState();
    _codeNumberController =
        TextEditingController(text: ''); // 새로운 TextEditingController 인스턴스 생성
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshContent();
    });
  }

  @override
  void dispose() {
    _codeNumberController.dispose(); // 컨트롤러 인스턴스 해제
    _barcodeFocus.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setActiveController() {
    setState(() {
      // TextEditingController의 텍스트를 초기화합니다.
      _codeNumberController.text = '';
      // 포커스를 재지정할 필요가 있으면 아래 주석을 해제하세요.
      FocusScope.of(context).requestFocus(_barcodeFocus);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 앱이 다시 활성화될 때 콘텐츠를 새로고침합니다.
      _refreshContent();
    }
  }

  void _refreshContent() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _codeNumberController.text = '';
        FocusScope.of(context).requestFocus(_barcodeFocus);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 90),
          child: Form(
            // Form 위젯을 추가합니다.
            key: _formKey, // GlobalKey<FormState>를 할당합니다.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "학생증의 바코드를\n리더기로 스캔해주세요.",
                  style: DevCoopTextStyle.bold_40.copyWith(
                    color: DevCoopColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 160),
                const SizedBox(height: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              _setActiveController();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 500,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 34, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Color(0xFFECECEC),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                // TextField 대신 TextFormField을 사용합니다.
                                controller: _codeNumberController,
                                focusNode: _barcodeFocus,
                                validator: (value) {
                                  // 여기에 validator 추가
                                  if (value == null || value.isEmpty) {
                                    return '학생증 번호를 입력해주세요.';
                                  }
                                  return null;
                                },
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              if (_formKey.currentState!.validate()) {
                                // Form이 유효할 경우에만 네비게이션을 실행합니다.
                                Get.toNamed("/pin",
                                    arguments: _codeNumberController.text);
                              }
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
      ),
    );
  }
}
