import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/component/GetHousekeeperList.dart';
import 'package:mutemaidservice/component/MyBookingDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class GetMyBookingData extends StatefulWidget {
  String UserID;
  ReservationData reservationData;
  AddressData addressData;
  Housekeeper housekeeper;
  String Duration;

  GetMyBookingData(
      {Key? key,
      required this.UserID,
      required this.Duration,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper})
      : super(key: key);

  @override
  State<GetMyBookingData> createState() => _GetMyBookingDataState();
}

class _GetMyBookingDataState extends State<GetMyBookingData> {
  Future<List<Map<String, dynamic>>> getAddressFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    DocumentSnapshot<Map<String, dynamic>> AddressSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.UserID)
            .collection('Address')
            .doc(widget.reservationData.AddressID)
            .get();
    Map<String, dynamic> AddressData = AddressSnapshot.data()!;
    data.add(AddressData);

    DocumentSnapshot<Map<String, dynamic>> HousekeeperSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.reservationData.HousekeeperID)
            .get();
    Map<String, dynamic> HousekeeperData = HousekeeperSnapshot.data()!;
    data.add(HousekeeperData);

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getAddressFromFirebase();
  }

  Future<void> _getAddressFromFirebase() async {
    dataList = await getAddressFromFirebase();
    if (mounted) {
      setState(() {});
    }
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      widget.addressData.Address = dataList[0]['AddressName'];
      widget.addressData.AddressDetail = dataList[0]['AddressDetail'];
      widget.addressData.Addressimage = dataList[0]['AddressImage'];

      widget.reservationData.addressImage = dataList[0]['AddressImage'];
      widget.reservationData.addressDetail = dataList[0]['AddressDetail'];
      widget.reservationData.addressName = dataList[0]['AddressName'];
      widget.reservationData.addresstype = dataList[0]['Type'];

      widget.housekeeper.LastName = dataList[1]['LastName'];
      widget.housekeeper.ProfileImage = dataList[1]['profileImage'];
      widget.housekeeper.FirstName = dataList[1]['FirstName'];
      widget.housekeeper.CommunicationSkill = dataList[1]['CommunicationSkill'];
      widget.housekeeper.HearRanking = dataList[1]['HearRanking'];
      widget.housekeeper.HousekeeperID = widget.housekeeper.HousekeeperID;
      widget.housekeeper.PhoneNumber = dataList[1]['PhoneNumber'];
      widget.housekeeper.Vaccinated = dataList[1]['Vaccinated'];
    }
    return MybookingDetail(
        UserID: widget.UserID,
        Duration: widget.Duration,
        reservationData: widget.reservationData,
        addressData: widget.addressData,
        housekeeper: widget.housekeeper);
  }
}
