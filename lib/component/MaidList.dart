import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocode/geocode.dart';

import 'package:mutemaidservice/component/CardPromotion.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

class MaidList extends StatefulWidget {
  bool booked;
  String userID;
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final String Reservation_Day;

  MaidList(
      {Key? key,
      required this.userID,
      required this.booked,
      required this.reservationData,
      required this.housekeeper,
      required this.Reservation_Day})
      : super(key: key);
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
  State<MaidList> createState() => _MaidListState();
}

Future<bool> DateTimeInReservation(
    String housekeeperid, String datetimeservice) async {
  List<Map<String, dynamic>> data = [];
  int count = 0;
  int i = 0;

  QuerySnapshot<Map<String, dynamic>> ReservationSnapshot =
      await FirebaseFirestore.instance
          .collection('User')
          .doc(UserID)
          .collection('Reservation')
          .get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> ReservationDoc
      in ReservationSnapshot.docs) {
    if (ReservationDoc[i]['Housekeeperid'] == housekeeperid) {
      if (ReservationDoc[i]['DatetimeService'] == datetimeservice) {
        count = count + 1;
      }
    }
    i++;
    if (count > 0) {
      return true;
    }
  }

  return false;
}

class _MaidListState extends State<MaidList> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Housekeeper").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                // scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((MaidDocument) {
                  return Center(
                    child: Flexible(
                        child: Column(children: [
                      MaidDetail(
                          widget.userID,
                          MaidDocument.id,
                          MaidDocument["FirstName"],
                          MaidDocument["LastName"],
                          MaidDocument["profileImage"],
                          MaidDocument["HearRanking"],
                          MaidDocument["Vaccinated"],
                          0, //double
                          MaidDocument["CommunicationSkill"],
                          false,
                          widget.booked,
                          widget.reservationData,
                          'null',
                          widget.housekeeper,
                          MaidDocument["PhoneNumber"],
                          widget.newAddress,
                          widget.Reservation_Day),
                      SizedBox(
                        height: 20,
                      ),
                    ])),
                  );
                }).toList(),
              );
            }
          }));
}
