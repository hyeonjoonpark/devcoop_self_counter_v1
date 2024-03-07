import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_constant/theme/devcoop_colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late String savedCodeNumber = '';

  @override
  void initState() {
    super.initState();
    loadUserData();

    // Delayed navigation after 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      navigateToNextPage();
    });
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? savedCodeNumber = prefs.getString('codeNumber');
      savedPoint = prefs.getInt('point') ?? 0;
      savedStudentName = prefs.getString('studentName') ?? '';
      savedCodeNumber = prefs.getString('codeNumber') ?? '';

      if (savedCodeNumber != "") {
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
    Get.toNamed('/payments');
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
                '${savedStudentName} 학생 \n 잔액 ${savedPoint}원 조회되었습니다',
                textAlign: TextAlign.center,
                style: GoogleFonts.nanumGothic(
                  fontSize: 30,
                  color: DevCoopColors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Image.asset(
                'assets/images/accept.png',
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
