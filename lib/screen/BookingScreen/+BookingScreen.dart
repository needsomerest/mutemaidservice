import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/MaidScreen/MaidScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../component/DropdownDay.dart';
import '../../component/DropdownPeriod.dart';
import '../../component/DropdownTime.dart';
import '../../component/Dropdownpackage.dart';
import '../../component/NoteSelect.dart';
import '../../component/Stepbar.dart';
import '../PlaceScreen/MyplaceScreen.dart';
import 'PackageDetail.dart';

class BookingScreen extends StatefulWidget {
  final bool home;
  List<String> package = ["รายเดือน"];
  BookingScreen(this.home);

  @override
  MyRecordState createState() => MyRecordState();
}

class MyRecordState extends State<BookingScreen> {
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
          title: Text('จองบริการ',
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
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.home == false) ...[
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 30),
                        child: stepbar(1),
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
                            height: 170,
                            width: 400,
                            margin: EdgeInsets.only(
                                top: 35, left: 20, right: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/location.png",
                                  height: 70,
                                  width: 70,
                                ),
                                Text(
                                  'สถานที่',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#06161C')),
                                ),
                                Text('กดเพื่อเพิ่มสถานที่ใช้บริการ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#000000')
                                            .withOpacity(0.5))),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Myplace(
                                      [1, 2, 3, 5, 4, 6, 8, 8, 8], true)));
                        },
                      ),
                    ] else ...[
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 30),
                        child: stepbar(4),
                      ),
                      Container(
                        height: 170,
                        width: 400,
                        margin: EdgeInsets.only(
                            top: 35, left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: HexColor('#5D5FEF').withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/home.png",
                              height: 70,
                              width: 70,
                            ),
                            Text(
                              'บ้านที่บางมด',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#06161C')),
                            ),
                            Text('ทาว์นโฮม/บ้านเดี่ยว',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        HexColor('#000000').withOpacity(0.5))),
                          ],
                        ),
                      ),
                    ],
                    // Container(
                    //   height: 50,
                    //   width: 500,
                    //   alignment: Alignment.topLeft,
                    //   margin: EdgeInsets.only(left: 20, right: 20),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Icon(
                    //             Icons.timelapse,
                    //           ),
                    //           SizedBox(width: 10),
                    //           Text(
                    //             'ระยะเวลาที่ให้บริการ',
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: HexColor('#06161C')),
                    //           ),
                    //         ],
                    //       ),
                    //       // Column(
                    //       //   children: [
                    //       Container(
                    //         margin: EdgeInsets.only(bottom: 10),
                    //         width: 170,
                    //         height: 50,
                    //         child: DropdownPeriod(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 30, bottom: 10),
                    //   alignment: Alignment.topRight,
                    //   child: Text(
                    //     '*ไม่รวมเวลาพักของผู้ให้บริการ',
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //       color: HexColor('5D5FEF'),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 70,
                      width: 500,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'เลือกวันที่ใช้บริการ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#06161C')),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 200,
                            child: DropdownDay(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'เลือกเวลาที่ใช้บริการ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#06161C')),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 150,
                            height: 40,
                            child: DropdownTime(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, right: 30, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.timelapse,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'ระยะเวลาที่ให้บริการ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#06161C')),
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 170,
                            height: 50,
                            child: DropdownPeriod(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 40, bottom: 10),
                      alignment: Alignment.topRight,
                      child: Text(
                        '*ไม่รวมเวลาพักของผู้ให้บริการ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: HexColor('5D5FEF'),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 30),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.repeat,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'แพ็กเกจ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#06161C')),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            child: Icon(
                              Icons.info,
                              color: HexColor('#5D5FEF'),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PackageDetail()));
                            },
                          ),
                          SizedBox(width: 50),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 170,
                            height: 40,
                            child: DropdownPackage(),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 25),
                        Icon(
                          Icons.star_outlined,
                          color: HexColor('5D5FEF'),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'หมายเหตุสำหรับผู้ให้บริการ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      'หมายเหตุนี้จะช่วยให้ผู้บริการทำงานได้ดีขึ้น',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 20),
                      width: 400,
                      height: 40,
                      child: NoteSelect(),
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
                          'ถัดไป',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          if (widget.home == false) {
                            _onAlertButtonPressedError(context);
                          } else {
                            if (widget.package == "ครั้งเดียว") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MaidScreen(false)));
                            } else {
                              _onAlertButtonPressed(context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ))));
  }
}

_onAlertButtonPressedError(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "โปรดเพิ่มสถานที่",
    desc: "โปรดเพิ่มสถานที่รับบริการก่อน",
    style: AlertStyle(
      titleStyle: TextStyle(
        // color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ตกลง",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: HexColor('#5D5FEF'),
      )
    ],
  ).show();
}

_onAlertButtonPressed(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ยืนยันการจองในระยะยาว",
    desc:
        "หากทำการยืนยันการจอง แม่บ้านจะเข้าไปทำความสะอาดให้ท่านในเวลาเดิมที่ท่านได้เลือกไว้",
    style: AlertStyle(
      titleStyle: TextStyle(
        // color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ยืนยัน",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MaidScreen(true)));
        },
        color: HexColor('#5D5FEF'),
        // borderRadius: BorderRadius.all(Radius.circular(2.0),
      ),
      DialogButton(
        child: Text(
          "ยกเลิก",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: HexColor('#BDBDBD').withOpacity(0.2),
      )
    ],
  ).show();
}
