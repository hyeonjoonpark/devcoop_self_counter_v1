import 'package:flutter/material.dart';
import '../../utils/devcoop_colors.dart';

Widget allItemsCount(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Column을 세로로 중앙에 정렬
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Row를 가로로 중앙에 정렬
          children: [
            Container(
              padding: const EdgeInsets.only(right:304, top: 24),
              child: const Text(
                "총 상품 개수 및 합계",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(left: 330, right: 64, top: 24),
              child: const Text(
                "1",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(right: 24, top: 24),
              child: const Text(
                "1400",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
