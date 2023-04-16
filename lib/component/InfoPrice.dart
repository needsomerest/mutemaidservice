import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';

class InfoPrice extends StatelessWidget {
  String TimeService;
  String Package;
  String AddressSize;
  PaymentData paymentData;
  InfoPrice(this.AddressSize, this.Package, this.TimeService, this.paymentData);

  int SumPrice() {
    int Price = 0;
    if (TimeService == '2 ชม.' || TimeService == '2 ชม. แนะนำ') {
      Price = Price + 80;
    } else if (TimeService == '3 ชม.') {
      Price = Price + 100;
    } else if (TimeService == '4 ชม.') {
      Price = Price + 120;
    } else if (TimeService == '5 ชม.') {
      Price = Price + 140;
    } else if (TimeService == '6 ชม.') {
      Price = Price + 160;
    } else if (TimeService == '7 ชม.') {
      Price = Price + 180;
    } else if (TimeService == '8 ชม.') {
      Price = Price + 200;
    } else {
      Price = Price + 0;
    }

    if (AddressSize == '40') {
      Price = Price + 180;
    } else if (AddressSize == '80') {
      Price = Price + 220;
    } else if (AddressSize == '120') {
      Price = Price + 300;
    } else {
      Price = Price + 0;
    }

    if (Package == 'รายครั้ง') {
      Price = Price + 220;
    } else if (Package == 'รายเดือน') {
      Price = Price + 180;
    } else if (Package == 'รายสัปดาห์') {
      Price = Price + 160;
    } else if (Package == 'รายวัน') {
      Price = Price + 100;
    } else {
      Price = Price + 0;
    }

    return Price;
  }

  @override
  Widget build(BuildContext context) {
    int Price = SumPrice();
    double tax = Price * 7 / 100;
    double sum = Price + tax;
    paymentData.PaymentPrice = sum;
    return Container(
      height: 270,
      width: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HexColor('#5D5FEF').withOpacity(0.2),
        border: Border.all(width: 1.5, color: HexColor('#5D5FEF')),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'ค่าบริการ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
            Text(
              Price.toStringAsFixed(2) + ' บาท',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              AddressSize,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
            Text(
              tax.toStringAsFixed(2) + ' บาท',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'รวมทั้งสิ้น',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#000000')),
            ),
            Text(
              sum.toStringAsFixed(2) + ' บาท',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#000000')),
            ),
          ]),
          Text(
            '*ราคานี้รวมค่าอุปกรณ์ น้ำยาทำความสะอาด และค่าเดินทางแล้ว',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HexColor('#979797')),
          ),
        ],
      ),
    );
  }
}
