import 'package:flutter/material.dart';

import '../../utils/devcoop_colors.dart';

Widget userSelectedItems(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Column을 세로로 중앙에 정렬
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Row를 가로로 중앙에 정렬
          children: [
            Container(
              padding: EdgeInsets.only(right:304, top: 24),
              child: const Text(
                "상품 이름",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 400, right: 24, top: 24),
              child: const Text(
                "수량",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(right: 16, top: 24),
              child: const Text(
                "상품 가격",
                style: TextStyle(
                  color: DevCoopColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
