import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:counter/presentation/ui/components/all_items_count.dart';
import 'package:counter/presentation/ui/components/payments_popup.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/utils/self_counter_button.dart';
import 'package:counter/presentation/ui/components/user_selected_items.dart';

void main() {
  runApp(MaterialApp(home: Payments()));
}

class Payments extends StatefulWidget {
  Payments();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Payments> {
  late String savedStudentName = ''; // Initialize with a default value
  late int savedPoint = 0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? savedCodeNumber = prefs.getString('codeNumber');
      String? savedPin = prefs.getString('pin');
      savedPoint = prefs.getInt('point') ?? 0;
      savedStudentName = prefs.getString('studentName') ?? '';

      if (savedCodeNumber != null && savedPin != null) {
        print("Getting UserInfo");
        print('Data loaded from SharedPreferences');
        setState(() {}); // Trigger a rebuild to update the UI
      }
    } catch (e) {
      print('Error during loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 56),
              child: Text(
                '$savedStudentName 학생  |  잔액 $savedPoint원',
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.7,
              margin: const EdgeInsets.only(top: 32),
              child: const Divider(
                color: Colors.black,
                thickness: 4,
              ),
            ),
            userSelectedItems(context),
            Container(
              width: screenWidth * 0.7,
              margin: const EdgeInsets.only(top: 456), // Adjusted the margin
              child: const Divider(
                color: Colors.black,
                thickness: 4,
              ),
            ),
            allItemsCount(context),
            Container(
              margin: const EdgeInsets.only(left: 856, top: 40),
              child: CounterElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return paymentsPopUp(context);
                    },
                  );
                },
                text: "계산하기",
                buttonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(DevCoopColors.primary),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: DevCoopColors.primary,
                      width: 2.0,
                    ),
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 32,
                  color: DevCoopColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
