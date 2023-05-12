import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';

class CalculatorPrice extends StatelessWidget {
  String TimeService;
  String Package;
  String AddressSize;
  CalculatorPrice(this.AddressSize, this.Package, this.TimeService);

  int Price = 0;

  void PriceTimeService(String TimeService) {
    if (TimeService == '2 ชม.' || TimeService == '2 ชม. แนะนำ') {
      Price = Price + 120;
    } else if (TimeService == '3 ชม.') {
      Price = Price + 190;
    } else if (TimeService == '4 ชม.') {
      Price = Price + 260;
    } else if (TimeService == '5 ชม.') {
      Price = Price + 380;
    } else if (TimeService == '6 ชม.') {
      Price = Price + 450;
    } else if (TimeService == '7 ชม.') {
      Price = Price + 520;
    } else if (TimeService == '8 ชม.') {
      Price = Price + 590;
    } else {
      Price = Price + 999;
    }
  }

  void PricePackage(String Package) {
    if (Package == 'ครั้งเดียว') {
      Price = Price + 400;
    } else if (Package == 'รายเดือน') {
      Price = Price + 600;
    } else if (Package == 'รายสัปดาห์') {
      Price = Price + 800;
    } else if (Package == 'รายวัน') {
      Price = Price + 900;
    } else {
      Price = Price + 0;
    }
  }

  void PricePlace(String AddressSize) {
    if (AddressSize == 40) {
      Price = Price + 280;
    } else if (AddressSize == 80) {
      Price = Price + 690;
    } else if (AddressSize == 120) {
      Price = Price + 970;
    } else {
      Price = Price + 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    PricePackage(Package);
    PricePlace(AddressSize);
    PriceTimeService(TimeService);
    return Text(
      Price.toString() + 'บาท',
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: HexColor('#000000')),
    );
  }
}
