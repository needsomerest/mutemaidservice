import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/RateStar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/Review.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';

import '../model/Data/HousekeeperData.dart';

class MybookingDetail extends StatefulWidget {
  String UserID;
  ReservationData reservationData;
  AddressData addressData;
  Housekeeper housekeeper;
  String Duration;
  MybookingDetail(
      {Key? key,
      required this.UserID,
      required this.Duration,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper})
      : super(key: key);
  @override
  State<MybookingDetail> createState() => _MybookingDetailState();
}

class _MybookingDetailState extends State<MybookingDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: Container(
              height: 330,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.addressData.Address,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: HexColor('#000000')),
                                    ),
                                    if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "กำลังตรวจสอบ") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Text(
                                          'รอผู้บริการรับงาน',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: HexColor('#F2C628'),
                                      ),
                                    ] else if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "ปฏิเสธ") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Text(
                                          'ผู้บริการปฏิเสธงาน',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: HexColor('#AD3B3B'),
                                      ),
                                    ] else if (widget.reservationData
                                            .HousekeeperRequest ==
                                        "ตอบรับ") ...[
                                      Chip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Text(
                                          'ผู้บริการรับงาน',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: HexColor('#1F8805'),
                                      ),
                                    ]
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
