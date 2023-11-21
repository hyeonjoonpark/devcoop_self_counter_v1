import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(String codeNumber, String pin, int point,
    String studentName, int studentNumber) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('codeNumber', codeNumber);
    prefs.setString('pin', pin);
    prefs.setInt('point', point);
    prefs.setString('studentName', studentName);
    prefs.setInt('studentNumber', studentNumber);
  } catch (e) {
    print(e);
  }
}
