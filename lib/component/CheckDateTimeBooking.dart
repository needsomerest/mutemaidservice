import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
  String callby;
  Housekeeper housekeeper;
  AddressData addressData;
  bool checkby;
  int distance;
  GeoPoint location_maid;
  CheckDateTimeBooking(
      {required this.UserID,
      required this.Reservation_Day,
      required this.reservationData,
      required this.callby,
      required this.housekeeper,
      required this.addressData,
      required this.booked,
      required this.checkby,
      required this.distance,
      required this.location_maid});

  @override
  State<CheckDateTimeBooking> createState() => _CheckDateTimeBookingState();
}

class _CheckDateTimeBookingState extends State<CheckDateTimeBooking> {
  bool ischecktime = true;
  bool checkjob = true;

  Future<bool> DateTimeInReservation() async {
    List<Map<String, dynamic>> data = [];
    int count = 0;

    // widget.reservationData.DateTimeService =
    //     DateFormat.yMMMMd('th').format(dateTime);

    QuerySnapshot<Map<String, dynamic>> ReservationSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.UserID)
            .collection('Reservation')
            .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> ReservationDoc
        in ReservationSnapshot.docs) {
      Map<String, dynamic> ReservationData = ReservationDoc.data();

      if (ReservationData["HousekeeperID"] ==
          widget.housekeeper.HousekeeperID) {
        if (ReservationData["DatetimeService"] ==
            widget.reservationData.DateTimeService) {
          count = count + 1;
        }
      }
      if (count > 0) {
        return false;
      }
    }

    return true;
  }

  final data = '';
  Future<bool> CheckTimeHousekeeper() async {
    QuerySnapshot HousekeeperSnapshot = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .where('HousekeeperID', isEqualTo: widget.housekeeper.HousekeeperID)
        .where('DateAvailable', arrayContains: widget.Reservation_Day)
        .get();
    if (HousekeeperSnapshot.docs.isNotEmpty) {
      return false;
    }
    return true;
  }

  void initState() {
    super.initState();
    initializeDateFormatting('th');

    CheckTimeHousekeeper().then((result) {
      setState(() {
        ischecktime = result;
      });
    });

    DateTimeInReservation().then((result) {
      setState(() {
        checkjob = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.checkby == true) ...[
            if (ischecktime == true && checkjob == true) ...[
              MaidDetail(
                widget.UserID,
                false,
                widget.booked,
                widget.reservationData,
                'null',
                widget.housekeeper,
                widget.addressData,
                widget.Reservation_Day,
                widget.distance,
                widget.location_maid,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ],
          if (widget.checkby == false) ...[
            if (widget.callby == 'menu') ...[
              GetFavMaid(
                booked: widget.booked,
                userid: widget.UserID,
                reservationData: widget.reservationData,
                callby: widget.callby,
                housekeeper: widget.housekeeper,
                addressData: widget.addressData,
                Reservation_Day: widget.Reservation_Day,
                distance: widget.distance,
              )
            ] else ...[
              if (ischecktime == true && checkjob == true) ...[
                GetFavMaid(
                  booked: widget.booked,
                  userid: widget.UserID,
                  reservationData: widget.reservationData,
                  callby: widget.callby,
                  housekeeper: widget.housekeeper,
                  addressData: widget.addressData,
                  Reservation_Day: widget.Reservation_Day,
                  distance: widget.distance,
                )
              ],
            ],
          ],
        ],
      ),
    );
  }
}
