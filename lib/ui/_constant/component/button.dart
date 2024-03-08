import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:flutter/material.dart';

GestureDetector mainTextButton({
  required String text,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30,
        ),
        color: DevCoopColors.primary,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: DevCoopColors.black.withOpacity(
              0.25,
            ),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Text(
        text,
        style: DevCoopTextStyle.bold_30.copyWith(
          color: DevCoopColors.black,
        ),
      ),
    ),
  );
}
