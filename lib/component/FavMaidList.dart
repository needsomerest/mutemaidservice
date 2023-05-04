import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/CheckDateTimeBooking.dart';
import 'package:mutemaidservice/component/GetFavMaid.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';

class FavMaidList extends StatefulWidget {
  bool booked;
  bool callbymenu;
  final ReservationData reservationData;
  String Reservation_Day;
  final AddressData addressData;
  final int maxdistance;
  FavMaidList(
      {Key? key,
      required this.booked,
      required this.reservationData,
      required this.callbymenu,
      required this.Reservation_Day,
      required this.addressData,
      required this.maxdistance})
      : super(key: key);

  @override
  State<FavMaidList> createState() => _FavMaidListState();
}

class _FavMaidListState extends State<FavMaidList> {
  @override
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(user!.uid.toString())
              .collection("FavHousekeeper")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("ยังไม่มีรายการผู้ให้บริการคนโปรด"),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((MaidDocument) {
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

                  newHousekeeper.HousekeeperID = MaidDocument.id;

                  return GetFavMaid(
                    booked: widget.booked,
                    userid: user!.uid,
                    reservationData: widget.reservationData,
                    callbymenu: widget.callbymenu,
                    housekeeper: newHousekeeper,
                    addressData: widget.addressData,
                    Reservation_Day: widget.Reservation_Day,
                    maxdistance: widget.maxdistance,
                  );
                }).toList(),
              );
            }
          }));
}
