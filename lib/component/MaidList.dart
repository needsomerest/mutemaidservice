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

class MaidList extends StatelessWidget {
  bool booked;
  String userID;
  final ReservationData reservationData;
  final Housekeeper housekeeper;

  MaidList({
    Key? key,
    required this.userID,
    required this.booked,
    required this.reservationData,
    required this.housekeeper,
  }) : super(key: key);
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
                          userID,
                          MaidDocument.id,
                          MaidDocument["FirstName"],
                          MaidDocument["LastName"],
                          MaidDocument["profileImage"],
                          MaidDocument["HearRanking"],
                          MaidDocument["Vaccinated"],
                          0, //double
                          MaidDocument["CommunicationSkill"],
                          false,
                          booked,
                          reservationData,
                          'null',
                          housekeeper,
                          MaidDocument["PhoneNumber"],
                          newAddress),
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
