import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/ConfirmScreen/ConfirmPayment.dart';
import '../../component/Stepbar.dart';
// import 'AddPlaceScreen.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading:
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
              //   }, child:
              Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          // ),
          //  Icon(
          //     Icons.keyboard_backspace,
          //     color: Colors.white,
          //   ),
          title: Text('การชำระเงินผ่านธนาคาร',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 850,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(children: [
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: stepbar(7),
              ),
              Container(
                height: 70,
                width: 350,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Flexible(
                  child: Text(
                    'ท่านสามารถเลือกวิธีชำระเงินได้หลายช่องทางตามความสะดวกของท่านการโอนเงินผ่านบัญชีธนาคารหรือ ATM โดยสามารถชำระเข้าบัญขีของบริษัทดังนี้',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: 250,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(30),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: HexColor('#5D5FEF').withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ธนาคาร : กสิกรไทย (KBANK)\nชื่อบัญชี : บจก เน็กซ์เจนไอที\nเลขบัญชี : 045-1-60685-9',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, height: 2),
                ),
              ),
              Container(
                height: 100,
                width: 350,
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 30),
                child: Flexible(
                  child: Text(
                    'เมื่อท่านได้ชำระเรียบร้อยแล้ว โปรดเก็บหลักฐานการโอนเงินจากธนาคารหรือ สลิปATM เพื่อใช้ในการแจ้งการโอนเงินกับทางเรา โดยแจ้งผ่านทางแบบฟอร์มด้านล่าง',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')),
                  ),
                ),
              ),
              Text(
                'อัพโหลดหลักฐานการชำระเงิน',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#5D5FEF')),
              ),
              InkWell(
                child: DottedBorder(
                  color: HexColor('#5D5FEF'),
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(20),
                  borderPadding: EdgeInsets.all(30),
                  strokeWidth: 2.5,
                  dashPattern: [10, 10],
                  child: Container(
                    height: 150,
                    width: 200,
                    margin: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 120,
                          color: HexColor('#5D5FEF'),
                        ),
                        Text(
                          'กดเพื่อเพิ่ม',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 500,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 20, top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmPayment(true)));
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
