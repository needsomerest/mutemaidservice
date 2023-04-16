import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/FavMaidList.dart';
import 'package:mutemaidservice/component/RateStar.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import '../BookingScreen/BookingScreen.dart';

class MyfavoriteScreen extends StatefulWidget {
  final String userID;
  MyfavoriteScreen({
    required this.userID,
  });

  @override
  State<MyfavoriteScreen> createState() => _MyfavoriteScreenState();
}

class _MyfavoriteScreenState extends State<MyfavoriteScreen> {
  final newReservationData = new ReservationData(
      "",
      "",
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      "14:30",
      "",
      "2 ชม. แนะนำ",
      Duration(
        hours: 0,
      ),
      "ครั้งเดียว",
      "เปลี่ยนผ้าคลุมเตียงและปลอกหมอน",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "ไม่มี",
      "",
      GeoPoint(0.0, 0.0),
      "",
      "",
      "",
      "กำลังตรวจสอบ",
      true,
      "");

  final newHousekeeper = Housekeeper("HousekeeperID", "FirstName", "LastName",
      "ProfileImage", 0, 0, 0, "CommunicationSkill", "PhoneNumber");

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
            height: 800,
            child: FavMaidList(
                housekeeper: newHousekeeper,
                booked: false,
                userID: widget.userID,
                reservationData: newReservationData,
                callby: 'menu',
                Reservation_Day: '-'),
          ),
        ) /*FavMaidList(
        booked: false,
        userID: widget.userID,
        callby: 'menu',
        reservationData: newReservationData,
      )*/
        );
  }
}
