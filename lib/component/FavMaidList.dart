import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/GetFavMaid.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class FavMaidList extends StatelessWidget {
  bool booked;
  String callby;
  String userID;
  final ReservationData reservationData;
  final Housekeeper housekeeper;

  FavMaidList(
      {Key? key,
      required this.booked,
      required this.userID,
      required this.reservationData,
      required this.callby,
      required this.housekeeper})
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
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(userID)
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
                  return GetFavMaid(
                    housekeeperid: MaidDocument['HousekeeperID'],
                    booked: booked,
                    userid: userID,
                    reservationData: reservationData,
                    callby: callby,
                    housekeeper: housekeeper,
                    addressData: newAddress,
                  );
                }).toList(),
              );
            }
          }));
}
