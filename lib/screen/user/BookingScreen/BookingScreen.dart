import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/DropdownPet.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingDistance.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../component/DropdownDay.dart';
import '../../../component/DropdownPeriod.dart';
import '../../../component/DropdownTime.dart';
import '../../../component/Dropdownpackage.dart';
import '../../../component/NoteSelect.dart';
import '../../../component/Stepbar.dart';
import '../PlaceScreen/MyplaceScreen.dart';
import 'PackageDetail.dart';

class BookingScreen extends StatefulWidget {
  final ReservationData reservationData;
  final AddressData addressData;
  final Housekeeper housekeeper;
  final bool callby;
  BookingScreen(
      {Key? key,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper,
      required this.callby})
      : super(key: key);

  List<String> package = ["รายเดือน"];

  @override
  MyRecordState createState() => MyRecordState();
}

class MyRecordState extends State<BookingScreen> {
  final User? user = Auth().currentUser;

  _onAlertButtonPressed(BuildContext context, String reservationday) {
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
            "ยกเลิก",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: HexColor('#BDBDBD').withOpacity(0.2),
        ),
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (widget.addressData.AddressID != "AddressID" ||
                widget.housekeeper.HousekeeperID != "HousekeeperID") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingDistanceScreen(
                            reservationData: widget.reservationData,
                            housekeeper: widget.housekeeper,
                            Reservation_Day: reservationday,
                            addressData: widget.addressData,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmInfo(
                          booked: true,
                          housekeeper: widget.housekeeper,
                          reservationData: widget.reservationData,
                          callby: false)));
              // Navigator.push(
              //     MaterialPageRoute(
              //         builder: (context) => ConfirmInfo(
              //                           booked: false,
              //                           housekeeper: widget.housekeeper,
              //                           reservationData: widget.reservationData,
              //                           callby: true,
              //                         )));
            }
          },
          color: HexColor('#5D5FEF'),
          // borderRadius: BorderRadius.all(Radius.circular(2.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    String uid = _uid.toString();
    String dayNameShort = DateFormat.E().format(DateTime.now());

    if (widget.addressData.AddressID == "AddressID") {
      widget.reservationData.AddressID = widget.addressData.AddressID;
      widget.reservationData.addressName = widget.addressData.Address;
      widget.reservationData.addresstype = widget.addressData.Type;
      widget.reservationData.addressDetail = widget.addressData.AddressDetail;
      widget.reservationData.addressImage = widget.addressData.Addressimage;
      widget.reservationData.sizeroom = "0";
      widget.reservationData.AddressPoint = widget.addressData.point;
      widget.reservationData.PhoneNumber = widget.addressData.Phonenumber;
    }

    if (widget.reservationData.HousekeeperID.isNotEmpty) {
      widget.reservationData.HousekeeperID = widget.housekeeper.HousekeeperID;
      widget.reservationData.HousekeeperFirstName =
          widget.housekeeper.FirstName;
      widget.reservationData.HousekeeperLastName = widget.housekeeper.LastName;
    }

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
                height: 1200,
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
                    /*Container(
                      child: Column(
                        children: [
                          if (widget
                              .reservationData.HousekeeperID.isNotEmpty) ...[
                            Container(
                              width: 300.0,
                              margin: EdgeInsets.only(top: 30),
                              child: stepbar(1),
                            ),
                          ] else ...{
                            Container(
                              width: 300.0,
                              margin: EdgeInsets.only(top: 30),
                              child: stepbar(1),
                            ),
                          }
                        ],
                      ),
                    ),*/

                    if (widget.addressData.AddressID == "AddressID") ...[
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
                                        book: true,
                                        reservationData: widget.reservationData,
                                        addressData: widget.addressData,
                                        housekeeper: widget.housekeeper,
                                      )));
                        },
                      ),
                    ] else ...[
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 30),
                        child: stepbar(2),
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
                            if (widget.addressData.Type == 'condo') ...[
                              Image.asset(
                                "assets/images/condo.png",
                                height: 70,
                                width: 70,
                              )
                            ] else ...[
                              Image.asset(
                                "assets/images/home.png",
                                height: 70,
                                width: 70,
                              )
                            ],
                            Text(
                              widget.reservationData
                                  .addressName /*widget.addressName*/,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#06161C')),
                            ),
                            Text(
                                widget.reservationData
                                    .addresstype /*widget.addresstype*/,
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
                          if (widget.housekeeper.HousekeeperID ==
                              "HousekeeperID") ...[
                            Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              child: DropdownDay(
                                reservationData: widget.reservationData,
                                callby: true,
                                UserID: uid,
                              ),
                            ),
                          ] else ...[
                            Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              child: DropdownDay(
                                reservationData: widget.reservationData,
                                callby: false,
                                UserID: uid,
                              ),
                            ),
                          ]
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
                            child: DropdownTime(
                              reservationData: widget.reservationData,
                            ),
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
                            child: DropdownPeriod(
                              reservationData: widget.reservationData,
                            ),
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
                          SizedBox(
                            width: 70,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 170,
                            height: 40,
                            child: DropdownPackage(
                              reservationData: widget.reservationData,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 50),
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
                                Icons.pets,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'สัตว์เลี้ยงในสถานที่',
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
                            child: DropdownPet(
                              reservationData: widget.reservationData,
                            ),
                          ),
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
                      child: NoteSelect(
                        reservationData: widget.reservationData,
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
                          'ถัดไป',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          initializeDateFormatting('th');
                          DateTime dateTime = DateFormat("yyyy-MM-dd")
                              .parse(widget.reservationData.DateTimeService);

                          dayNameShort = DateFormat.E().format(dateTime);

                          if (widget.housekeeper.HousekeeperID !=
                                  'HousekeeperID' ||
                              widget.addressData.AddressID != 'AddressID') {
                            if (widget.reservationData.Package ==
                                "ครั้งเดียว") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookingDistanceScreen(
                                            reservationData:
                                                widget.reservationData,
                                            housekeeper: widget.housekeeper,
                                            Reservation_Day: dayNameShort,
                                            addressData: widget.addressData,
                                          )));
                            } else {}
                          }

                          // if (widget.reservationData.AddressID == "") {
                          //   _onAlertButtonPressedError(context);
                          // } else {
                          //   if (widget.reservationData.HousekeeperID !=
                          //       'HousekeeperID') {
                          //     if (widget.reservationData.Package ==
                          //         "ครั้งเดียว") {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => ConfirmInfo(
                          //                     booked: false,
                          //                     reservationData:
                          //                         widget.reservationData,
                          //                     housekeeper: widget.housekeeper,
                          //                     callby: false,
                          //                   )));
                          //     } else {
                          //       _onAlertButtonPressed(context, dayNameShort);
                          //     }
                          //   } else {
                          //     if (widget.reservationData.Package ==
                          //         "ครั้งเดียว") {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   BookingDistanceScreen(
                          //                     reservationData:
                          //                         widget.reservationData,
                          //                     housekeeper: widget.housekeeper,
                          //                     Reservation_Day: dayNameShort,
                          //                     addressData: widget.addressData,
                          //                   )));
                          //     } else {
                          //       _onAlertButtonPressed(context, dayNameShort);
                          //     }
                          //   }
                          // }
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
