class PaymentData {
  String PaymentImage;
  String PaymentStatus = "กำลังตรวจสอบ";
  int PaymentPrice = 0;

  PaymentData(this.PaymentImage, this.PaymentStatus, this.PaymentPrice);

  Map<String, dynamic> CreatePaymenttoJson() => {
        'PaymentImage': PaymentImage,
        'PaymentStatus': PaymentStatus,
        'PaymentPrice': PaymentPrice,
      };
}
