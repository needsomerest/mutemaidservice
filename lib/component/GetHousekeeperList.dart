import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/component/MyBookingDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class GetHousekeeperData extends StatefulWidget {
  String UserID;
  ReservationData reservationData;
  AddressData addressData;
  Housekeeper housekeeper;
  String Duration;

  GetHousekeeperData(
      {Key? key,
      required this.UserID,
      required this.Duration,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper})
      : super(key: key);

  @override
  State<GetHousekeeperData> createState() => _GetHousekeeperDataState();
}

class _GetHousekeeperDataState extends State<GetHousekeeperData> {
  Future<List<Map<String, dynamic>>> getHousekeeperFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Address')
            .doc(widget.reservationData.AddressID)
            .get();
    Map<String, dynamic> HousekeeperData = userSnapshot.data()!;
    data.add(HousekeeperData);

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getHousekeeperFromFirebase();
  }

  Future<void> _getHousekeeperFromFirebase() async {
    dataList = await getHousekeeperFromFirebase();
    if (mounted) {
      setState(() {
        /* widget.housekeeper.LastName = dataList[0]['LastName'];
        widget.housekeeper.FirstName = dataList[0]['FirstName'];
        widget.housekeeper.ProfileImage = dataList[0]['profileImage'];*/
      });
    }
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {}
    return MybookingDetail(
        UserID: widget.UserID,
        Duration: widget.Duration,
        reservationData: widget.reservationData,
        addressData: widget.addressData,
        housekeeper: widget.housekeeper);
  }
}
