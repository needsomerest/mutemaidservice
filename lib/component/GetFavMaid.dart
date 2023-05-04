import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/CheckDateTimeBooking.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:validators/sanitizers.dart';

class GetFavMaid extends StatefulWidget {
  bool booked;
  String userid;
  ReservationData reservationData;
  bool callbymenu;
  Housekeeper housekeeper;
  AddressData addressData;
  String Reservation_Day;
  int maxdistance;

  GetFavMaid({
    Key? key,
    required this.booked,
    required this.userid,
    required this.reservationData,
    required this.callbymenu,
    required this.housekeeper,
    required this.addressData,
    required this.Reservation_Day,
    required this.maxdistance,
  });

  @override
  State<GetFavMaid> createState() => _GetFavMaidState();
}

class _GetFavMaidState extends State<GetFavMaid> {
  final User? user = Auth().currentUser;
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.housekeeper.HousekeeperID)
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
    if (mounted) {
      setState(() {});
    }
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      widget.housekeeper.FirstName = dataList[0]['FirstName'];
      widget.housekeeper.LastName = dataList[0]['LastName'];
      widget.housekeeper.ProfileImage = dataList[0]['profileImage'];
      widget.housekeeper.HearRanking = dataList[0]['HearRanking'];
      widget.housekeeper.Vaccinated = dataList[0]['Vaccinated'];
      widget.housekeeper.CommunicationSkill = dataList[0]['CommunicationSkill'];
      widget.housekeeper.PhoneNumber = dataList[0]['PhoneNumber'];

      if (widget.callbymenu == true) {
        return MaidDetail(
            widget.userid,
            true,
            widget.booked,
            widget.reservationData,
            widget.callbymenu,
            widget.housekeeper,
            widget.addressData,
            widget.Reservation_Day,
            widget.maxdistance,
            dataList[0]['CurrentLocation']);
      }
      return CheckDateTimeBooking(
        UserID: user!.uid,
        Reservation_Day: widget.Reservation_Day,
        reservationData: widget.reservationData,
        callbymenu: widget.callbymenu,
        housekeeper: widget.housekeeper,
        addressData: widget.addressData,
        booked: widget.booked,
        callbymaid: false,
        maxdistance: widget.maxdistance,
        location_maid: dataList[0]['CurrentLocation'],
      );
    }

    return SizedBox();

    //return SizedBox();
  }
}
