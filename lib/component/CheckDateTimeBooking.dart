import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/GetFavMaid.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class CheckDateTimeBooking extends StatefulWidget {
  String UserID;
  String Reservation_Day;
  bool booked;
  ReservationData reservationData;
  bool callbymenu;
  Housekeeper housekeeper;
  AddressData addressData;
  bool callbymaid;
  int maxdistance;
  GeoPoint location_maid;
  CheckDateTimeBooking(
      {required this.UserID,
      required this.Reservation_Day,
      required this.reservationData,
      required this.callbymenu,
      required this.housekeeper,
      required this.addressData,
      required this.booked,
      required this.callbymaid,
      required this.maxdistance,
      required this.location_maid});

  @override
  State<CheckDateTimeBooking> createState() => _CheckDateTimeBookingState();
}

class _CheckDateTimeBookingState extends State<CheckDateTimeBooking> {
  bool ischecktime = true;
  bool checkjob = true;

  Future<bool> DateTimeInReservation() async {
    List<Map<String, dynamic>> data = [];
    // if (widget.reservationData.DateTimeService != "DateTimeService") {
    //   initializeDateFormatting('th');
    //   DateTime dateTime = DateFormat("yyyy-MM-dd")
    //       .parse(widget.reservationData.DateTimeService);

    //   widget.reservationData.DateTimeService =
    //       DateFormat.yMMMMd('th').format(dateTime);
    // }

    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> ReservationSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(UserDoc.id)
              .collection('Reservation')
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> ReservationDoc
          in ReservationSnapshot.docs) {
        if (ReservationDoc['HousekeeperID'] ==
            widget.housekeeper.HousekeeperID) {
          if (ReservationDoc['DatetimeService'] ==
              widget.reservationData.DateTimeService) {
            return true;
          }
        }
      }
    }

    return false;
  }

  final data = '';
  Future<bool> CheckTimeHousekeeper() async {
    QuerySnapshot HousekeeperSnapshot = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .where('HousekeeperID', isEqualTo: widget.housekeeper.HousekeeperID)
        .where('DateAvailable', arrayContains: widget.Reservation_Day)
        .get();
    if (HousekeeperSnapshot.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  void initState() {
    super.initState();
    initializeDateFormatting('th');

    CheckTimeHousekeeper().then((result_time) {
      setState(() {
        ischecktime = result_time;
      });
    });

    DateTimeInReservation().then((result_reserve) {
      setState(() {
        checkjob = result_reserve;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (ischecktime == false && checkjob == false) ...[
            MaidDetail(
              widget.UserID,
              false,
              widget.booked,
              widget.reservationData,
              false,
              widget.housekeeper,
              widget.addressData,
              widget.Reservation_Day,
              widget.maxdistance,
              widget.location_maid,
            ),
          ],
        ],
      ),
    );
  }
}
