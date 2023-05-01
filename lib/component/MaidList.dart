import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocode/geocode.dart';

import 'package:mutemaidservice/component/CardPromotion.dart';
import 'package:mutemaidservice/component/CheckDateTimeBooking.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

class MaidList extends StatefulWidget {
  bool booked;
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressData;
  final String Reservation_Day;
  final int distance;

  MaidList(
      {Key? key,
      required this.booked,
      required this.reservationData,
      required this.housekeeper,
      required this.Reservation_Day,
      required this.addressData,
      required this.distance});

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
  final User? user = Auth().currentUser;
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
                  newHousekeeper.FirstName = MaidDocument["FirstName"];
                  newHousekeeper.LastName = MaidDocument["LastName"];
                  newHousekeeper.ProfileImage = MaidDocument["profileImage"];
                  newHousekeeper.HearRanking = MaidDocument["HearRanking"];
                  newHousekeeper.Vaccinated = MaidDocument["Vaccinated"];
                  newHousekeeper.CommunicationSkill =
                      MaidDocument["CommunicationSkill"];
                  newHousekeeper.PhoneNumber = MaidDocument["PhoneNumber"];
                  return Center(
                    child: Flexible(
                        child: Column(children: [
                      CheckDateTimeBooking(
                        UserID: user!.uid,
                        Reservation_Day: widget.Reservation_Day,
                        reservationData: widget.reservationData,
                        callby: 'maidlist',
                        housekeeper: newHousekeeper,
                        addressData: widget.addressData,
                        booked: widget.booked,
                        checkby: true,
                        distance: widget.distance,
                        location_maid: MaidDocument["CurrentLocation"],
                      ),
                      // MaidDetail(
                      //     widget.userID,
                      //     0, //double
                      //     false,
                      //     widget.booked,
                      //     widget.reservationData,
                      //     'null',
                      //     newHousekeeper,
                      //     widget.newAddress,
                      //     widget.Reservation_Day),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ])),
                  );
                }).toList(),
              );
            }
          }));
}
