import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/CheckDateTimeBooking.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';

class FavMaidList extends StatefulWidget {
  bool booked;
  String callby;
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  String Reservation_Day;
  final AddressData addressData;
  final int distance;
  FavMaidList(
      {Key? key,
      required this.booked,
      required this.reservationData,
      required this.callby,
      required this.housekeeper,
      required this.Reservation_Day,
      required this.addressData,
      required this.distance})
      : super(key: key);

  @override
  State<FavMaidList> createState() => _FavMaidListState();
}

class _FavMaidListState extends State<FavMaidList> {
  @override
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
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(user!.uid)
              .collection("FavHousekeeper")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
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

                  return CheckDateTimeBooking(
                    UserID: user!.uid,
                    Reservation_Day: widget.Reservation_Day,
                    reservationData: widget.reservationData,
                    callby: widget.callby,
                    housekeeper: newHousekeeper,
                    addressData: widget.addressData,
                    booked: widget.booked,
                    checkby: false,
                    distance: widget.distance,
                    location_maid: GeoPoint(0.0, 0.0),
                  );
                }).toList(),
              );
            }
          }));
}
