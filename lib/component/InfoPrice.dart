import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoPrice extends StatelessWidget {
  const InfoPrice({super.key});

  @override
  Widget build(BuildContext context) {
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
              '500.00 บาท',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'ภาษีมูลค่าเพิ่ม 7%',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
            Text(
              '35.00 บาท',
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
              '535.00 บาท',
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
