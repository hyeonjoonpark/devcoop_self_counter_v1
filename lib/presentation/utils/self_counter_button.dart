import 'package:counter/presentation/utils/devcoop_colors.dart';
import 'package:flutter/material.dart';

class CounterElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  CounterElevatedButton(
      {required this.text,
      required this.onPressed,
      required this.buttonStyle,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
      style: buttonStyle,
    );
  }
}
