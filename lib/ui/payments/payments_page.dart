import 'dart:convert';

import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
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
  List<ItemResponseDto> itemResponses = [];

  TextEditingController barcodeController = TextEditingController();
  FocusNode barcodeFocusNode = FocusNode(); // 추가된 부분

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> fetchItemData(String barcode) async {
    try {
      final apiUrl = 'http://localhost:8080/kiosk';
      final response =
          await http.get(Uri.parse('$apiUrl/itemSelect?barcodes=$barcode'));

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> itemJsonList = jsonDecode(response.body);
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

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        savedPoint = prefs.getInt('point') ?? 0;
        savedStudentName = prefs.getString('studentName') ?? '';
      });

      if (savedPoint != 0 && savedStudentName.isNotEmpty) {
        print("Getting UserInfo");
        print('Data loaded from SharedPreferences');
      }
    } catch (e) {
      print('Error during loading data: $e');
    }
  }

  void showPaymentsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return paymentsPopUp(context);
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

  @override
  void dispose() {
    barcodeController.dispose();
    barcodeFocusNode.dispose(); // 추가된 부분
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
                        showPaymentsPopup(context);
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
