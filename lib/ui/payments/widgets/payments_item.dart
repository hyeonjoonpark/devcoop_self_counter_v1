import 'package:counter/ui/_constant/theme/devcoop_colors.dart';
import 'package:counter/ui/_constant/theme/devcoop_text_style.dart';
import 'package:counter/ui/_constant/util/number_format_util.dart';
import 'package:flutter/material.dart';

Row paymentsItem({
  required String left,
  required String center,
  int? right,
  String? rightText,
  bool contentsTitle = false,
  bool totalText = true,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          left,
          style: contentsTitle
              ? DevCoopTextStyle.medium_30.copyWith(
                  color: DevCoopColors.black,
                )
              : !totalText
                  ? DevCoopTextStyle.light_30.copyWith(
                      color: DevCoopColors.black,
                    )
                  : DevCoopTextStyle.bold_30.copyWith(
                      color: DevCoopColors.black,
                    ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        width: 155,
        alignment: Alignment.centerRight,
        child: Text(center,
            style: contentsTitle
                ? DevCoopTextStyle.medium_30.copyWith(
                    color: DevCoopColors.black,
                  )
                : !totalText
                    ? DevCoopTextStyle.light_30.copyWith(
                        color: DevCoopColors.black,
                      )
                    : DevCoopTextStyle.bold_30.copyWith(
                        color: DevCoopColors.black,
                      )),
      ),
      Container(
        width: 155,
        alignment: Alignment.centerRight,
        child: Text(rightText ?? NumberFormatUtil.convert1000Number(right!),
            style: contentsTitle
                ? DevCoopTextStyle.medium_30.copyWith(
                    color: DevCoopColors.black,
                  )
                : !totalText
                    ? DevCoopTextStyle.light_30.copyWith(
                        color: DevCoopColors.black,
                      )
                    : DevCoopTextStyle.bold_30.copyWith(
                        color: DevCoopColors.black,
                      )),
      ),
    ],
  );
}
