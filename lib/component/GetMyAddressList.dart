import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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

  Future<String> lastDateTimePayment() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('User')
        .doc(widget.UserID)
        .collection('Reservation')
        .doc(widget.reservationData.BookingID)
        .collection('Payment')
        .orderBy('DateTime', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String result = '';
      if (snapshot.docs.length == 1) {
        var latestDoc = snapshot.docs[0]['PaymentStatus'];
        result = latestDoc.toString(); // print the data of the latest document
      } else if (snapshot.docs.length > 1) {
        var latestDoc = snapshot.docs[0]['PaymentStatus'].first;
        result = latestDoc.toString(); // print the data of the latest document
      }
      return result;
    } else {
      return 'No documents found';
    }
  }

  List<Map<String, dynamic>> dataList = [];
  String PaymentStatus = '';
  @override
  void initState() {
    super.initState();
    _getAddressFromFirebase();
  }

  Future<void> _getAddressFromFirebase() async {
    dataList = await getAddressFromFirebase();
    PaymentStatus = await lastDateTimePayment();
    if (mounted) {
      setState(() {});
    }
    // print(dataList);
  }

  Future _CheckPaymentDate(DateTime datetime_now, String datetime_change,
      DateTime datetime_payment) async {
    if (datetime_now.isAfter(datetime_payment) &&
        widget.reservationData.PaymentUpload == true) {
      FirebaseFirestore.instance
          .collection("User")
          .doc(widget.UserID)
          .collection('Reservation')
          .doc(widget.reservationData.BookingID)
          .update({"DatetimeService": datetime_change, "PaymentUpload": false});
    }
    if (datetime_now.isAfter(datetime_payment) &&
        widget.reservationData.PaymentUpload == false) {
      FirebaseFirestore.instance
          .collection("User")
          .doc(widget.UserID)
          .collection('Reservation')
          .doc(widget.reservationData.BookingID)
          .update({"Status": "ประวัติ"});
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    String DateTimePackage = '';
    DateTime dateTime = DateFormat('dd MMMM ค.ศ. yyyy', 'th')
        .parse(widget.reservationData.DateTimeService);
    DateTime date_payment =
        DateTime(dateTime.year, dateTime.month, dateTime.day - 7);
    DateTimePackage = DateFormat.yMMMMd('th').format(date_payment);

    DateTime date_payment_two =
        DateTime(dateTime.year, dateTime.month - 1, dateTime.day);
    String DateTime_change = DateFormat.yMMMMd('th').format(date_payment_two);

    DateTime dateTime_now = DateTime.now();
    String string_datetime_now = DateFormat.yMMMMd('th').format(dateTime_now);
    void initState() {
      super.initState();
      _CheckPaymentDate(dateTime_now, DateTime_change.toString(), date_payment);
    }
    // DateTime dateTime_two = DateFormat("yyyy-MM-dd").parse(DateTimePackage);
    // String string_date_payment = DateFormat.yMMMMd('th').format(dateTime_two);

    if (dataList.isNotEmpty) {
      widget.addressData.Address = dataList[0]['AddressName'];
      widget.addressData.AddressDetail = dataList[0]['AddressDetail'];
      widget.addressData.Addressimage = dataList[0]['AddressImage'];

      widget.reservationData.addressImage = dataList[0]['AddressImage'];
      widget.reservationData.addressDetail = dataList[0]['AddressDetail'];
      widget.reservationData.addressName = dataList[0]['AddressName'];
      widget.reservationData.addresstype = dataList[0]['Type'];
      widget.reservationData.sizeroom = dataList[0]['Sizeroom'];

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
        housekeeper: widget.housekeeper,
        PaymentStatus: PaymentStatus,
        Datetime_end: DateTimePackage);
  }
}
