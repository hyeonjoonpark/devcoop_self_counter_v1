import 'package:counter/ui/payments/widgets/payments_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentsGetx extends GetxController {
  static PaymentsGetx get to => Get.find<PaymentsGetx>();


Future payment({
    required BuildContext context,
}) async {
  // 결제 api 함수
  // api 호출 성공시
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return paymentsPopUp(context);
    },
  );
}
}
