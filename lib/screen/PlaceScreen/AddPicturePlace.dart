import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/BookingScreen/+BookingScreen.dart';
import '../../component/Stepbar.dart';
import 'AddPlaceScreen.dart';

class addpictureplace extends StatelessWidget {
  const addpictureplace({super.key});

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
          title: Text('เพิ่มสถานที่ใช้บริการ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 900,
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
                child: stepbar(4),
              ),
              Text(
                'อัพโหลดรูปสถานที่ของฉัน',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 30, bottom: 50),
                child: Flexible(
                    child: Text(
                  'โปรดเพิ่มรูปภายนอกบ้าน/อาคารให้เห็นบริเวณหน้าบ้านอย่างชัดเจนเพื่อความสะดวกรวดเร็วและแม่นยำในการให้บริการ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#979797')),
                )),
              ),
              Text(
                'ตัวอย่างรูปภาพที่ถูกต้อง',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#979797')),
              ),
              Image.asset(
                "assets/images/ex.home.jpg",
                height: 240,
              ),
              SizedBox(
                height: 30,
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
                              color: HexColor('#5D5FEF')),
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
                margin: EdgeInsets.only(right: 20, top: 30),
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
                            builder: (context) => BookingScreen(true)));
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
