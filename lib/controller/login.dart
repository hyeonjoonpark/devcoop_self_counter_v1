import 'dart:convert';

import 'package:counter/controller/save_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController {
  Future<void> login(
      BuildContext context, String codeNumber, String pin) async {
    print(codeNumber);
    print(pin);
    Map<String, String> requestBody = {'codeNumber': codeNumber, 'pin': pin};

    String jsonData = json.encode(requestBody);
    print(jsonData);

    String apiUrl = 'http://localhost:8080/kiosk/auth/signIn';
    print(apiUrl);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonData,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print("로그인 성공");

        Map<String, dynamic> responseBody =
            json.decode(response.body) as Map<String, dynamic>;

        jsonDecode(utf8.decode(response.bodyBytes))['result'];

        print("responseBody = $responseBody");

        String token = responseBody['token'] ?? '';
        String studentName = responseBody['studentName'] ?? '';
        int studentNumber = responseBody['studentNumber'] ?? 0;
        int point = responseBody['point'] ?? 0;

        Object result =
            saveUserData(token, codeNumber, studentNumber, point, studentName);

        print(result);
        print("저장성공");

        Get.toNamed('/check');
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }
}
