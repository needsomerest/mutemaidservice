import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/BookingScreen/+BookingScreen.dart';
import 'package:mutemaidservice/screen/ConfirmScreen/ConfirmInfoScreen.dart';
import '../../component/MaidDetail.dart';
import '../HomeScreen.dart';
import '../../component/RateStar.dart';
import '../MaidScreen/MaidDetailScreen.dart';

class MyBooking extends StatefulWidget {
  // const MyBooking({super.key});
  List<int> booking;
  MyBooking(this.booking);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
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
        title: Text('การจองของฉัน',
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
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'กำลังมาถึง',
                      style: TextStyle(
                        color: Colors.transparent,
                        decorationColor: HexColor('#5D5FEF'),
                        decorationThickness: 4,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: HexColor('#5D5FEF'),
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'เสร็จสิ้น',
                      style: TextStyle(
                        color: Colors.transparent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: HexColor('#BDBDBD'),
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'ยกเลิก',
                      style: TextStyle(
                        color: Colors.transparent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: HexColor('#BDBDBD'),
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (widget.booking.length >= 1) ...[
                InkWell(
                  child: Container(
                    height: 300,
                    child: MaidDetail(
                        "คุณกนกพร สุขใจ",
                        "assets/images/profilemaid.png",
                        3,
                        4,
                        2,
                        3,
                        2.15,
                        "ภาษามือ, การเขียน, ล่าม",
                        false,
                        true),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmInfo(true)));
                  },
                ),
              ] else ...[
                SizedBox(
                  height: 50,
                ),
                Text('ยังไม่มีรายการ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#5D5FEF"),
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(130, 40),
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingScreen(false)));
                  },
                )
              ]
            ]),
            width: 400,
            height: 700,
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
