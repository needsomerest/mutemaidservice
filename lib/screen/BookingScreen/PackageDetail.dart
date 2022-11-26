import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../component/DropdownArea.dart';
import '../../component/LocationForm.dart';
import '../HomeScreen.dart';

class PackageDetail extends StatelessWidget {
  const PackageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 30,
        ),
        title: Text('รายละเอียดแพ็กเกจ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'การจองแบบครั้งเดียว',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Flexible(
                child: Text(
                  'ในการจองแบบครั้งเดียว แม่บ้านจะเข้าไปให้บริการในวัน เวลาที่ท่านได้ทำการจองไว้',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'การจองแบบรายเดือน',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Flexible(
                child: Text(
                  "ในการจองแบบรายเดือน แม่บ้านจะเข้าไปทำความสะอาดในทุกเดือนตามเวลาที่ท่านได้ทำการจองไว้ เช่น หากท่านจองในวันที่ 15 เวลา 12.00 น. แม่บ้านจะเข้าไปทำความสะอาดทุกวันที่ 15 เวลา 12.00 น. ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'การจองแบบรายสัปดาห์',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Flexible(
                child: Text(
                  'ในการจองแบบรายสัปดาห์ แม่บ้านจะเข้าไปทำความสะอาด ในทุกสัปดาห์ตามเวลาที่ท่านได้ทำการจองไว้ เช่น หากท่านจองในวันพุธที่ 15 เวลา 12.00 น. แม่บ้านจะเข้าไปทำความสะอาดทุกวันพุธ เวลา 12.00 น.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'การจองแบบรายวัน',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Flexible(
                child: Text(
                  'ในการจองแบบรายวัน แม่บ้านจะเข้าไปทำความสะอาด ในทุกวันตามเวลาที่ท่านได้ทำการจองไว้ เช่น หากท่านจองในวันพุธที่ 15 เวลา 12.00 น. แม่บ้านจะเข้าไปทำความสะอาดทุกวัน เวลา 12.00 น.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}
