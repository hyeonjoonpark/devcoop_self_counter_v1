import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:counter/presentation/ui/view/payments_page.dart';

void main() {
  runApp(MaterialApp(
    home: CheckStudent(),
  ));
}

class CheckStudent extends StatefulWidget {
  CheckStudent();

  @override
  _CheckStudentState createState() => _CheckStudentState();
}

class _CheckStudentState extends State<CheckStudent> {
  late String savedStudentName = ''; // Initialize with a default value
  late int savedPoint = 0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    loadUserData();

    // Delayed navigation after 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      navigateToNextPage();
    });
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

  void navigateToNextPage() {
    // Use Navigator to push a new page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Payments()), // Replace with your destination page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Text(
                '$savedStudentName 학생 \n 잔액 $savedPoint원 조회되었습니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: DevCoopColors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Image.asset(
                'assets/accept.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
