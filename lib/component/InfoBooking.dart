import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoAtom.dart';

class InfoBooking extends StatelessWidget {
  const InfoBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HexColor('#5D5FEF').withOpacity(0.2),
        border: Border.all(width: 1.5, color: HexColor('#5D5FEF')),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ผู้ให้บริการ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(Icons.person, "คุณกนกพร สุขใจ", "0"),
          Text(
            'เวลาทำงาน',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(Icons.calendar_month, "วันที่ใช้บริการ", "20 กันยายน 2022"),
          InfoAtom(Icons.schedule, "เวลาที่ใช้บริการ", "12:30 - 14:30 น."),
          InfoAtom(Icons.timelapse, "ระยะเวลาที่ให้บริการ", "2 ชม."),
          InfoAtom(Icons.repeat, "แพ็กเกจ", "รายวัน"),
          Text(
            'รายละเอียดงาน',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(Icons.home, "ขนาดที่พัก", "80 - 120 ตรม."),
          InfoAtom(Icons.pets, "สัตว์เลี้ยง", "สุนัข"),
          Text(
            '*หมายเหตุ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          Text(
            'โปรดทำความสะอาดเครื่องหนังอย่างระมัดระวัง',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HexColor('#000000')),
          ),
        ],
      ),
    );
  }
}
