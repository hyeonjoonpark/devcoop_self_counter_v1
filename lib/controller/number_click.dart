import 'package:flutter/material.dart';

void onNumberButtonPressed(
    int number, TextEditingController _activeController) {
  if (_activeController != null) {
    String currentText = _activeController.text;

    if (number == 10) {
      _activeController.clear(); // Clear focus and text
    } else if (number == 12) {
      // Del button
      if (currentText.isNotEmpty) {
        String newText = currentText.substring(0, currentText.length - 1);
        _activeController.text = newText;
      }
    } else {
      String newText = currentText + (number == 11 ? '0' : number.toString());
      _activeController.text = newText;
    }
  }
}
