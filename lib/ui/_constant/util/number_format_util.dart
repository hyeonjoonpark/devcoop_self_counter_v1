import 'package:intl/intl.dart';

class NumberFormatUtil {
  static String convert1000Number(int num) => NumberFormat("#,###").format(num);
}
