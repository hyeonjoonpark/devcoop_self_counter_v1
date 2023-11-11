import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../presentation/ui/view/check_student.dart';

Future<void> saveUserData(
    String codeNumber, String pin, int point, String studentName) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('codeNumber', codeNumber);
    await prefs.setString('pin', pin);
    await prefs.setInt('point', point);
    await prefs.setString('studentName', studentName);
  } catch (e) {
    print(e);
  }
}

Future<void> login(BuildContext context) async {
  Map<String, dynamic> requestData = {'codeNumber': '2022058', 'pin': '123456'};

  String jsonData = json.encode(requestData);

  final response = await http.post(
    Uri.parse('http://localhost:8080/kiosk/auth/signIn'),
    body: jsonData,
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    String codeNumber = responseBody['data']['user']['codeNumber'];
    String pin = responseBody['data']['user']['pin'];
    int point = responseBody['data']['user']['point'];
    String studentName = responseBody['data']['user']['studentName'];

    await saveUserData(codeNumber, pin, point, studentName);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckStudent()),
    );
  } else {
    throw Exception('Internal Server Error');
  }
}
