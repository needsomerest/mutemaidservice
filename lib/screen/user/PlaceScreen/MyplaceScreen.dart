import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/PlaceAtom.dart';
import 'package:mutemaidservice/component/PlaceGrid.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/MenuScreen.dart';
import '../BookingScreen/MyBooking.dart';
import 'AddPlaceScreen.dart';

class Myplace extends StatefulWidget {
  bool book;
  final ReservationData reservationData;
  final AddressData addressData;
  final Housekeeper housekeeper;
  Myplace(
      {Key? key,
      required this.book,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper})
      : super(key: key);

  // List<int> place;

  // const Myplace({super.key});

  @override
  State<Myplace> createState() => _MyplaceState();
}

class _MyplaceState extends State<Myplace> {
  final newHousekeeper = Housekeeper("HousekeeperID", "FirstName", "LastName",
      "ProfileImage", 0, 0, 0, "CommunicationSkill", "PhoneNumber");

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
              if (widget.book == false) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(
                            reservationData: widget.reservationData,
                            addressData: newAddress,
                            housekeeper: newHousekeeper,
                            backward: false)));
              }
            },
          ),
          // ),
          //  Icon(
          //     Icons.keyboard_backspace,
          //     color: Colors.white,
          //   ),
          title: Text('สถานที่ของฉัน',
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
              if (widget.book == true) ...[
                Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 30),
                  child: stepbar(2),
                ),
              ] else ...[
                SizedBox(
                  height: 30,
                )
              ],
              // if (widget.place.length >= 1) ...[
              Container(
                width: 400,
                height: 500,
                // height: widget.place.length % 2 == 0
                //     ? widget.place.length * 100
                //     : (widget.place.length + 1) * 100,
                child: PlaceGrid(
                  reservationData: widget.reservationData,
                  addressData: widget.addressData,
                  housekeeper: widget.housekeeper,
                ),
              ),
              // ],
              Container(
                height: 50,
                width: 500,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: Text(
                    'เพิ่มสถานที่ใช้บริการ',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  // child: Text(
                  //   'เพิ่มสถานที่ใช้บริการ',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget.book == false
                                ? Addplace(false, false)
                                : Addplace(true, false)));
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
