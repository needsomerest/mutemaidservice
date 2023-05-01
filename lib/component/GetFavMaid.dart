import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:validators/sanitizers.dart';

class GetFavMaid extends StatefulWidget {
  bool booked;
  String userid;
  ReservationData reservationData;
  String callby;
  Housekeeper housekeeper;
  AddressData addressData;
  String Reservation_Day;
  int distance;

  GetFavMaid({
    Key? key,
    required this.booked,
    required this.userid,
    required this.reservationData,
    required this.callby,
    required this.housekeeper,
    required this.addressData,
    required this.Reservation_Day,
    required this.distance,
  });

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
    setState(() {});
    print(dataList);
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
      return MaidDetail(
          widget.userid,
          true,
          widget.booked,
          widget.reservationData,
          widget.callby,
          widget.housekeeper,
          widget.addressData,
          widget.Reservation_Day,
          widget.distance,
          dataList[0]['CurrentLocation']);
    } else {
      return Container();
    }
  }
}
