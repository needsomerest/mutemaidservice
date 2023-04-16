import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class GetFavMaid extends StatefulWidget {
  String housekeeperid;
  bool booked;
  String userid;
  ReservationData reservationData;
  String callby;
  Housekeeper housekeeper;
  AddressData addressData;
  String Reservation_Day;

  GetFavMaid(
      {Key? key,
      required this.housekeeperid,
      required this.booked,
      required this.userid,
      required this.reservationData,
      required this.callby,
      required this.housekeeper,
      required this.addressData,
      required this.Reservation_Day});

  @override
  State<GetFavMaid> createState() => _GetFavMaidState();
}

class _GetFavMaidState extends State<GetFavMaid> {
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.housekeeperid)
            .get();
    Map<String, dynamic> UserData = userSnapshot.data()!;
    data.add(UserData);

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {});
    print(dataList);
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      return MaidDetail(
          widget.userid,
          widget.housekeeperid,
          dataList[0]['FirstName'],
          dataList[0]['LastName'],
          dataList[0]['profileImage'],
          dataList[0]['HearRanking'],
          dataList[0]['Vaccinated'],
          0,
          dataList[0]['CommunicationSkill'],
          true,
          widget.booked,
          widget.reservationData,
          widget.callby,
          widget.housekeeper,
          dataList[0]['PhoneNumber'],
          widget.addressData,
          widget.Reservation_Day);
      dataList = [];
    } else {
      return Container();
    }
  }
}

/**
 * 

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

                        true,
                        booked,
                        reservationData,
                        callby,
                        housekeeper, MaidDocument["PhoneNumber"],
                      ),
                    ])),
                  );
                }).toList(),
              );
            }
          }));
}

 */