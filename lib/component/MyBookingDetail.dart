import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/chatpage.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/Review.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatScreen.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmPayment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/Data/HousekeeperData.dart';

class MybookingDetail extends StatefulWidget {
  String UserID;
  ReservationData reservationData;
  AddressData addressData;
  Housekeeper housekeeper;
  String Duration;
  String PaymentStatus;

  String Datetime_end;
  MybookingDetail(
      {Key? key,
      required this.UserID,
      required this.Duration,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper,
      required this.PaymentStatus,
      required this.Datetime_end})
      : super(key: key);
  @override
  State<MybookingDetail> createState() => _MybookingDetailState();
}

class _MybookingDetailState extends State<MybookingDetail> {
  Future EndReservation() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(widget.UserID)
        .collection("Reservation")
        .doc(widget.reservationData.BookingID)
        .update({"Status": "เสร็จสิ้น"});
  }

  _onAlertSucessReservationButtonPressed(BuildContext context) {
    final User? user = Auth().currentUser;
    Alert(
      context: context,
      type: AlertType.warning,
      title: "สิ้นสุดการจอง",
      desc: "หากทำการสิ้นสุดการจองบริการ ระบบจะทำการสิ้นสุดการจองนี้ของท่าน",
      style: AlertStyle(
        titleStyle: TextStyle(
          color: Colors.red,
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
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            EndReservation();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

  @override
  Widget build(BuildContext context) {
    PaymentData newpaymentdata = new PaymentData('', 'กำลังตรวจสอบ', 0.0);
    ReservationData newservationdata = ReservationData(
        widget.reservationData.BookingID,
        widget.reservationData.AddressID,
        widget.reservationData.DateTimeService,
        widget.reservationData.TimeStartService,
        widget.reservationData.TimeEndService,
        widget.reservationData.Timeservice,
        widget.reservationData.TimeDuration,
        widget.reservationData.Package,
        widget.reservationData.Note,
        widget.reservationData.addressName,
        widget.reservationData.addresstype,
        widget.reservationData.addressDetail,
        widget.reservationData.addressImage,
        widget.reservationData.HousekeeperID,
        widget.reservationData.HousekeeperFirstName,
        widget.reservationData.HousekeeperLastName,
        widget.reservationData.sizeroom,
        widget.reservationData.Pet,
        widget.reservationData.AddressNote,
        widget.reservationData.AddressPoint,
        widget.reservationData.PhoneNumber,
        widget.reservationData.UserRegion,
        widget.reservationData.Status,
        widget.reservationData.HousekeeperRequest,
        widget.reservationData.PaymentUpload,
        "");

    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: Container(
              height: 400,
              width: 380,
              // margin: EdgeInsets.(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                // color: Colors.red,
                color: HexColor('#5D5FEF').withOpacity(0.10),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Reservation ID : " + widget.reservationData.BookingID,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: HexColor('#9D9D9D')),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // alignment: Alignment.topCenter,
                          // margin: EdgeInsets.only(botto),
                          margin: EdgeInsets.all(10),
                          height: 70,
                          width: 70,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.addressData.Addressimage),
                            radius: 220,
                          ),
                        ),
                        Container(
                          height: 230,
                          width: 280,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  //mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.addressData.Address,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: HexColor('#000000')),
                                      ),
                                    ),
                                    if (widget.PaymentStatus ==
                                        'กำลังตรวจสอบ') ...[
                                      if (widget
                                              .reservationData.PaymentUpload ==
                                          true) ...[
                                        Chip(
                                          labelPadding: EdgeInsets.all(2.0),
                                          label: Icon(Icons.payments_rounded,
                                              color: HexColor('#FFFFFF')),
                                          backgroundColor: HexColor('#F2C628'),
                                        )
                                      ],
                                      if (widget
                                              .reservationData.PaymentUpload ==
                                          false) ...[
                                        Chip(
                                            labelPadding: EdgeInsets.all(2.0),
                                            label: Icon(Icons.payments_rounded,
                                                color: HexColor('#FFFFFF')),
                                            backgroundColor:
                                                HexColor('#AD3B3B'))
                                      ],
                                    ],
                                    if (widget.PaymentStatus ==
                                        'เสร็จสิ้น') ...[
                                      if (widget
                                              .reservationData.PaymentUpload ==
                                          true) ...[
                                        Chip(
                                          labelPadding: EdgeInsets.all(2.0),
                                          label: Icon(Icons.payments_rounded,
                                              color: HexColor('#FFFFFF')),
                                          backgroundColor: HexColor('#1F8805'),
                                        ),
                                      ],
                                      if (widget
                                              .reservationData.PaymentUpload ==
                                          false) ...[
                                        Chip(
                                            labelPadding: EdgeInsets.all(2.0),
                                            label: Icon(Icons.payments_rounded,
                                                color: HexColor('#FFFFFF')),
                                            backgroundColor:
                                                HexColor('#AD3B3B'))
                                      ],
                                    ],
                                    if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "กำลังตรวจสอบ") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Icon(
                                            Icons.cleaning_services_rounded,
                                            color: HexColor('#FFFFFF')),
                                        backgroundColor: HexColor('#F2C628'),
                                      ),
                                    ] else if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "ไม่รับงาน") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Icon(
                                            Icons.cleaning_services_rounded,
                                            color: HexColor('#FFFFFF')),
                                        backgroundColor: HexColor('#AD3B3B'),
                                      ),
                                    ] else if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "รับงาน") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Icon(
                                            Icons.cleaning_services_rounded,
                                            color: HexColor('#FFFFFF')),
                                        backgroundColor: HexColor('#1F8805'),
                                      ),
                                    ],
                                  ]),
                              Text(widget.addressData.AddressDetail,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: HexColor('#000000'))),
                              SizedBox(
                                height: 20,
                              ),
                              Text("วันที่เลือกใช้บริการ : " +
                                  widget.reservationData.DateTimeService),
                              Text("แพ็กเกจ : " +
                                  widget.reservationData.Package),
                              Text("เวลาที่ใช้บริการ : " +
                                  widget.reservationData.TimeStartService +
                                  " - " +
                                  widget.reservationData.TimeEndService +
                                  "   ( " +
                                  widget.reservationData.Timeservice +
                                  " )"),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ผู้ให้บริการ : " +
                                        widget.housekeeper.FirstName +
                                        "   " +
                                        widget.housekeeper.LastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          if (widget.reservationData.Status == 'เสร็จสิ้น') ...[
                            Container(
                              height: 40,
                              width: 150,
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
                                  'รีวิวผู้ให้บริการ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewScreen(
                                                reservationData:
                                                    widget.reservationData,
                                                housekeeper: widget.housekeeper,
                                              )));
                                },
                              ),
                            ),
                            Divider(
                              color: HexColor(
                                  '#DDDDDD'), //color of divider//height spacing of divider
                              thickness:
                                  1, //thickness of divier linespacing at the end of divider
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ] else if (widget.reservationData.Status ==
                              'กำลังมาถึง') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.reservationData.Package !=
                                        'ครั้งเดียว' &&
                                    widget.reservationData.PaymentUpload ==
                                        false) ...[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center,
                                      backgroundColor: HexColor("#5D5FEF"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      minimumSize: Size(100, 40),
                                    ),
                                    child: Text(
                                      'ชำระเงิน',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmPayment(
                                                    paymentdata: newpaymentdata,
                                                    paid: false,
                                                    reservationData:
                                                        newservationdata,
                                                    callby: false,
                                                  )));
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center,
                                      backgroundColor: HexColor("#5D5FEF"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      minimumSize: Size(100, 40),
                                    ),
                                    child: Text(
                                      'สิ้นสุดการจอง',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () {
                                      _onAlertSucessReservationButtonPressed(
                                          context);
                                    },
                                  ),
                                ],
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                    backgroundColor: HexColor("#5D5FEF"),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    minimumSize: Size(60, 40),
                                  ),
                                  child: Icon(Icons.chat_outlined),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                widget.UserID,
                                                widget.housekeeper
                                                    .HousekeeperID)));
                                  },
                                ),
                              ],
                            ),
                            if (widget.reservationData.Package !=
                                    'ครั้งเดียว' &&
                                widget.reservationData.PaymentUpload ==
                                    false) ...[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ' หมายเหตุ* กรุณาทำการชำระเงินก่อน ${widget.Datetime_end} หากไม่ทำการชำระเงินในวันที่กำหนดระบบจะทำการยกเลิกงานภายในวันนั้น',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 12),
                                textAlign: TextAlign.left,
                              )
                            ],
                            Divider(
                              color: HexColor(
                                  '#DDDDDD'), //color of divider//height spacing of divider
                              thickness:
                                  1, //thickness of divier linespacing at the end of divider
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ] else ...[
                            Divider(
                              color: HexColor(
                                  '#DDDDDD'), //color of divider//height spacing of divider
                              thickness:
                                  1, //thickness of divier linespacing at the end of divider
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ]
                        ],
                      ),
                    )
                  ])),
          onTap: () {
            widget.reservationData.HousekeeperFirstName =
                widget.housekeeper.FirstName;
            widget.reservationData.HousekeeperLastName =
                widget.housekeeper.LastName;
            if (widget.reservationData.Status == 'เสร็จสิ้น' ||
                widget.reservationData.Status == 'ประวัติ') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmInfo(
                            booked: true,
                            housekeeper: widget.housekeeper,
                            reservationData: widget.reservationData,
                            callby: true,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmInfo(
                            booked: true,
                            housekeeper: widget.housekeeper,
                            reservationData: widget.reservationData,
                            callby: false,
                          )));
            }
          },
        ),
      ],
    ));
  }
}
