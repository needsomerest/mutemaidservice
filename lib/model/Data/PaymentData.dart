import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PaymentData {
  String PaymentImage;
  String PaymentStatus = "กำลังตรวจสอบ";
  double PaymentPrice = 0;

  PaymentData(this.PaymentImage, this.PaymentStatus, this.PaymentPrice);

  Map<String, dynamic> CreatePaymenttoJson() => {
        'PaymentImage': PaymentImage,
        'PaymentStatus': PaymentStatus,
        'PaymentPrice': PaymentPrice,
        'DateTime': datetime(),
      };

  DateTime datetime() {
    initializeDateFormatting('th');
    DateTime datetime = DateTime.now();
    //String datetime = DateFormat.yMMMMd('th').format(DateTime.now()).toString();
    return datetime;
  }
}
