import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/GetMyAddressList.dart';
import 'package:mutemaidservice/component/MyBookingDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/BookingScreen/BookingScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyBookingList extends StatelessWidget {
  String UserID;
  String TabStatus;
  MyBookingList({required this.UserID, required this.TabStatus});

  final newReservationDataA = new ReservationData(
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
      "กำลังตรวจสอบ");

  final newHousekeeperA = Housekeeper("HousekeeperID", "FirstName", "LastName",
      "ProfileImage", 0, 0, 0, "CommunicationSkill", "PhoneNumber");

  final newAddressA = AddressData(
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
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(UserID)
              .collection("Reservation")
              .where('Status', isEqualTo: TabStatus)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Column(
                  children: [
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
                        'จองตอนนี้',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen(
                                      reservationData: newReservationDataA,
                                      addressData: newAddressA,
                                      housekeeper: newHousekeeperA,
                                    )));
                      },
                    )
                  ],
                ));
              } else {
                return ListView(
                  // scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((ReservationDocument) {
                    final newReservationData = new ReservationData(
                        "",
                        "",
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.now())
                            .toString(),
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
                        "กำลังตรวจสอบ");

                    final newHousekeeper = Housekeeper(
                        "HousekeeperID",
                        "FirstName",
                        "LastName",
                        "ProfileImage",
                        0,
                        0,
                        0,
                        "CommunicationSkill",
                        "PhoneNumber");

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

                    newReservationData.BookingID = ReservationDocument.id;
                    newReservationData.DateTimeService =
                        ReservationDocument['DatetimeService'];
                    newReservationData.Note = ReservationDocument['Note'];
                    newReservationData.Package = ReservationDocument['Package'];
                    newReservationData.Status = ReservationDocument['Status'];
                    String TimeDuration = ReservationDocument['TimeDuration'];
                    newReservationData.TimeEndService =
                        ReservationDocument['TimeEndService'];
                    newReservationData.Timeservice =
                        ReservationDocument['TimeService'];
                    newReservationData.TimeStartService =
                        ReservationDocument['TimeStartService'];
                    newReservationData.AddressID =
                        ReservationDocument['AddressID'];
                    newReservationData.HousekeeperID =
                        ReservationDocument['HousekeeperID'];
                    newReservationData.HousekeeperRequest =
                        ReservationDocument['HousekeeperRequest'];
                    newHousekeeper.HousekeeperID =
                        ReservationDocument['HousekeeperID'];

                    return GetMyBookingData(
                        UserID: UserID,
                        Duration: TimeDuration,
                        reservationData: newReservationData,
                        addressData: newAddress,
                        housekeeper: newHousekeeper);

                    /* MybookingDetail(
                          Duration: TimeDuration,
                          reservationData: newReservationData,
                          addressData: newAddress,
                          housekeeper: newHousekeeper,
                        )*/
                  }).toList(),
                );
              }
            }
          }));
}
