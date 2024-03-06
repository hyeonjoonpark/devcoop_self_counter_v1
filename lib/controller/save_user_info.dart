import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(String token, String codeNumber, int studentNumber,
    String pin, int point, String studentName) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
    prefs.setString('codeNumber', codeNumber);
    prefs.setString('pin', pin);
    prefs.setInt('point', point);
    prefs.setString('studentName', studentName);
  } catch (e) {
    print(e);
  }
}
