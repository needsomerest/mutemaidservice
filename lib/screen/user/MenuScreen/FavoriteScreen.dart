import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/FavMaidList.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/MenuScreen.dart';

class MyfavoriteScreen extends StatefulWidget {
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

  final newAddress = AddressData(
      "AddressID",
      "Addressimage",
      "Type",
      "SizeRoom",
      "Address",
      "AddressDetail",
      "Province",
      "District",
      "Phonenumber",
      "Note",
      "User",
      GeoPoint(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          title: Text('ส่งงานให้แม่บ้านคนโปรด',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            child: FavMaidList(
              addressData: newAddress,
              booked: false,
              reservationData: newReservationData,
              callbymenu: true,
              Reservation_Day: '-',
              maxdistance: 100,
            ),
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
