import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/contact.dart';
// import 'HomeScreen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
        title: Text('ติดต่อเรา',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 890,
          width: double.infinity,
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'พิชญาภรณ์ หัสเมตโต',
              //           style: TextStyle(
              //               fontSize: 20,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w500),
              //         ),
              //         Text(
              //           'แก้ไขโปรไฟล์',
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w500),
              //         ),
              //       ],
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(bottom: 20),
              //       child: Image.asset(
              //         "assets/images/profile.png",
              //         width: 70,
              //         height: 70,
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                  // margin: EdgeInsets.only(top: 30),
                  height: 800,
                  decoration: BoxDecoration(
                      color: HexColor('#FFFFFF'),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ฝ่ายสนับสนุน',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child:
                              contact("assets/images/viber.png", "0-2470-8000"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child: contact(
                              "assets/images/line.png", "@MuteMaidService"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child: contact(
                              "assets/images/facebook.png", "MuteMaid Service"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'สถานที่ตั้งบริษัท',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child: contact("assets/images/locationcontact.png",
                              "126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140"),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          decoration: BoxDecoration(
              color: HexColor('#5D5FEF').withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}
