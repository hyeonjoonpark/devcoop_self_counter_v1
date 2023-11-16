import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Dto/item_response_dto.dart';
import '../_constant/component/button.dart';
import 'widgets/payments_item.dart';
import 'widgets/payments_popup.dart';

class PaymentsPage extends StatefulWidget {
  PaymentsPage({Key? key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String savedStudentName = '';
  int savedPoint = 0;
  int totalPrice = 0;
  String savedCodeNumber = ''; // 수정: null 허용
  List<ItemResponseDto> itemResponses = [];

  TextEditingController barcodeController = TextEditingController();
  FocusNode barcodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        savedPoint = prefs.getInt('point') ?? 0;
        savedStudentName = prefs.getString('studentName') ?? '';
        savedCodeNumber = prefs.getString('codeNumber')!;
      });

      if (savedPoint != 0 && savedStudentName.isNotEmpty) {
        print("Getting UserInfo");
        print('Data loaded from SharedPreferences');
      }

      if (savedCodeNumber == null) {
        print('codeNumber가 설정되지 않았습니다.');
      }
    } catch (e) {
      print('Error during loading data: $e');
    }
  }

  Future<void> fetchItemData(String barcode) async {
    try {
      final apiUrl = 'http://localhost:8080/kiosk';
      final response =
          await http.get(Uri.parse('$apiUrl/itemSelect?barcodes=$barcode'));

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> itemJsonList =
            jsonDecode(utf8.decode(response.bodyBytes));
        final Map<String, dynamic> responseBody = itemJsonList.first;
        final String itemName = responseBody['name'];
        final int itemPrice = responseBody['price'];

        setState(() {
          final item =
              ItemResponseDto(itemName: itemName, itemPrice: itemPrice);
          itemResponses.add(item);

          totalPrice += itemPrice;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void showPaymentsPopup(BuildContext context, int totalPrice) {
    deductPoints();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return paymentsPopUp(context, totalPrice);
      },
    );
  }

  void handleBarcodeSubmit() {
    String barcode = barcodeController.text;
    if (barcode.isNotEmpty) {
      fetchItemData(barcode);

      // 상품 선택 후 바코드 입력창 초기화
      barcodeController.clear();
    }
  }

  Future<void> deductPoints() async {
    try {
      final apiUrl = 'http://localhost:8080/kiosk';

      Map<String, dynamic> requestBody = {
        'codeNumber': savedCodeNumber,
        'totalPrice': totalPrice
      };
      String jsonData = json.encode(requestBody);

      print(jsonData);
      final response = await http.put(
        Uri.parse('$apiUrl/pay'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      print(response);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리되었을 때의 동작 추가
        print('Points deducted successfully');
      } else {
        // 요청이 실패했을 때의 동작 추가
        print('Failed to deduct points');
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred while deducting points: $e');
    }
  }

  @override
  void dispose() {
    barcodeController.dispose();
    barcodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // 다른 곳을 탭하면 포커스 해제
          barcodeFocusNode.unfocus();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 90,
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$savedStudentName 학생  |  $savedPoint 원',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      // TextFormField로 변경
                      controller: barcodeController,
                      focusNode: barcodeFocusNode,
                      decoration: InputDecoration(
                        hintText: '바코드 입력',
                      ),
                      onFieldSubmitted: (_) {
                        handleBarcodeSubmit();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  mainTextButton(
                    text: '상품선택',
                    onTap: () {
                      handleBarcodeSubmit();
                    },
                  ),
                ],
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
                              for (int i = 0;
                                  i < itemResponses.length;
                                  i++) ...[
                                paymentsItem(
                                  left: itemResponses[i].itemName ?? '',
                                  center: '1',
                                  rightText: itemResponses[i].itemPrice != null
                                      ? itemResponses[i].itemPrice.toString()
                                      : '0',
                                  totalText: false,
                                ),
                                if (i < itemResponses.length - 1) ...[
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
                        center: itemResponses.length.toString(),
                        rightText: totalPrice.toString(), // 수정: 값을 String으로 변환
                      ),
                    ),
                    mainTextButton(
                      text: '계산하기',
                      onTap: () {
                        showPaymentsPopup(context, totalPrice);
                      },
                    ),
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

AlertDialog paymentsPopUp(BuildContext context, int totalPrice) {
  // Delayed navigation after 5 seconds
  Future.delayed(const Duration(seconds: 3), () {
    removeUserData();
    navigateToNextPage();
  });

  return AlertDialog(
    content: Container(
      width: 520,
      height: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$totalPrice원을 결제할게요',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "잠시후에 처음화면으로 돌아갑니다",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
