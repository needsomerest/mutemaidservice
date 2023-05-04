import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/CheckDateTimeBooking.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

class MaidList extends StatefulWidget {
  bool booked;
  final ReservationData reservationData;
  final AddressData addressData;
  final String Reservation_Day;
  final int maxdistance;

  MaidList(
      {Key? key,
      required this.booked,
      required this.reservationData,
      required this.Reservation_Day,
      required this.addressData,
      required this.maxdistance});

  @override
  State<MaidList> createState() => _MaidListState();
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
                        callbymenu: false,
                        housekeeper: newHousekeeper,
                        addressData: widget.addressData,
                        booked: widget.booked,
                        callbymaid: true,
                        maxdistance: widget.maxdistance,
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
