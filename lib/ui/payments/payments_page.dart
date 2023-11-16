import 'package:counter/ui/payments/widgets/payments_item.dart';
import 'package:counter/ui/payments/widgets/payments_popup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../_constant/component/button.dart';

class PaymentsPage extends StatefulWidget {
  PaymentsPage({Key? key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String savedStudentName = ''; // Initialize with a default value
  int savedPoint = 0; // Initialize with a default value

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
              '$savedStudentName 학생  |  $savedPoint 잔액 원',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
                      showPaymentsPopup(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
