import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/FavMaidList.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/component/MaidList.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingDistance.dart';

class MaidScreen extends StatefulWidget {
  // const MaidScreen({super.key});
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressData;
  final String Reservation_Day;
  final int maxdistance;

  MaidScreen(
      {Key? key,
      required this.reservationData,
      required this.housekeeper,
      required this.Reservation_Day,
      required this.addressData,
      required this.maxdistance})
      : super(key: key);

  bool fav = false;

  @override
  State<MaidScreen> createState() => _MaidScreenState();
}

class _MaidScreenState extends State<MaidScreen> {
  final User? user = Auth().currentUser;
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingDistanceScreen(
                        reservationData: widget.reservationData,
                        housekeeper: widget.housekeeper,
                        Reservation_Day: widget.Reservation_Day,
                        addressData: widget.addressData)));
          },
        ),
        title: Text('เลือกแม่บ้านด้วยตนเอง',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12),
          width: 600,
          height: 1000,
          // constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 30),
                child: stepbar(3),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.fav == false) ...[
                      Text(
                        'ล่าสุด',
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
                      InkWell(
                          child: Text(
                            'แม่บ้านคนโปรด',
                            style: TextStyle(
                              color: widget.fav == true
                                  ? HexColor('#5D5FEF')
                                  : Colors.transparent,
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
                          onTap: () {
                            setState(() {
                              widget.fav = true;
                            });
                          }),
                    ] else ...[
                      InkWell(
                          child: Text(
                            'ล่าสุด',
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
                          onTap: () {
                            setState(() {
                              widget.fav = false;
                            });
                          }),
                      Text(
                        'แม่บ้านคนโปรด',
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
                    ]
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (widget.fav == false) ...[
                Container(
                  height: 620,
                  child: MaidList(
                    booked: false,
                    reservationData: widget.reservationData,
                    addressData: widget.addressData,
                    Reservation_Day: widget.Reservation_Day,
                    maxdistance: widget.maxdistance,
                  ),
                )
              ] else ...[
                Container(
                  height: 620,
                  child: FavMaidList(
                    booked: false,
                    reservationData: widget.reservationData,
                    callbymenu: false,
                    addressData: widget.addressData,
                    Reservation_Day: widget.Reservation_Day,
                    maxdistance: widget.maxdistance,
                  ),
                ),
              ]
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
