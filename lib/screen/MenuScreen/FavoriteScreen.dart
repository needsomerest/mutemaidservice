import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/RateStar.dart';
import 'package:mutemaidservice/screen/BookingScreen/+BookingScreen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
        title: Text('ส่งงานให้แม่บ้านคนโปรด',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 1000,
          // constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              SizedBox(height: 20),
              Container(
                  height: 300,
                  width: 395,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    color: HexColor('#5D5FEF').withOpacity(0.10),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/profilemaid.png",
                          ),
                        ),
                        Container(
                          height: 220,
                          width: 280,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'คุณกนกพร สุขใจ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: HexColor('#000000')),
                                  ),
                                  Icon(
                                    Icons.bookmark,
                                    color: HexColor('#5D5FEF'),
                                    size: 30.0,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Ratestar(5),
                                    width: 110,
                                    height: 50,
                                  ),
                                  Text(
                                    '5.0 (10 reviews)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/ear.png",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'ระดับการได้ยิน 5',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                Image.asset(
                                  "assets/images/syringe.png",
                                  height: 23,
                                  width: 23,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'รับวัคซีนป้องกันโควิด 19 จำนวน 3 เข็ม',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/texttosign.png",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'สื่อสารด้วย : ภาษามือ, การเขียน, ภาพ, ล่าม',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/locationpoint.png",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '2.15 กม.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 20),
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
                          'จอง',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingScreen(false)));
                        },
                      ),
                    )
                  ])),
            ]),
            width: 400,
            height: 700,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                // color: HexColor('#BDBDBD').withOpacity(0.25),
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
