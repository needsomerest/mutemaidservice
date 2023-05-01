import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/NotificationData.dart';
import 'package:mutemaidservice/model/auth.dart';

class NotificationScreen extends StatefulWidget {
  NotificationData notificationdata;

  NotificationScreen({required this.notificationdata});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Future<List<Map<String, dynamic>>> getReservaitionFromFirebase() async {
    List<Map<String, dynamic>> data = [];
    DocumentSnapshot<Map<String, dynamic>> ReservationSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.notificationdata.UserID)
            .collection('Reservation')
            .doc(widget.notificationdata.ReservationID)
            .get();
    Map<String, dynamic> ReservationData = ReservationSnapshot.data()!;
    data.add(ReservationData);

    DocumentSnapshot<Map<String, dynamic>> AddressSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.notificationdata.UserID)
            .collection('Address')
            .doc(ReservationData['AddressID'])
            .get();
    Map<String, dynamic> AddressData = AddressSnapshot.data()!;
    data.add(AddressData);

    DocumentSnapshot<Map<String, dynamic>> HousekeeperSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(ReservationData['HousekeeperID'])
            .get();
    Map<String, dynamic> HousekeeperData = HousekeeperSnapshot.data()!;
    data.add(HousekeeperData);

    return data;
  }

  Future<String> lastDateTimePayment() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('User')
        .doc(widget.notificationdata.UserID)
        .collection('Reservation')
        .doc(widget.notificationdata.ReservationID)
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
    _getReservationFromFirebase();
  }

  Future<void> _getReservationFromFirebase() async {
    dataList = await getReservaitionFromFirebase();
    PaymentStatus = await lastDateTimePayment();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 30,
        ),
        title: Text('การแจ้งเตือน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.notificationdata.Header}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: HexColor('#000000')),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("${widget.notificationdata.NotificationDetail}"),
                SizedBox(
                  height: 40,
                ),
                if (dataList.isNotEmpty) ...[
                  Container(
                      height: 280,
                      width: 380,
                      // margin: EdgeInsets.(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        color: HexColor('#5D5FEF').withOpacity(0.10),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "Reservation ID : " +
                                    widget.notificationdata.ReservationID,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: HexColor('#9D9D9D')),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // alignment: Alignment.topCenter,
                                  // margin: EdgeInsets.only(botto),
                                  margin: EdgeInsets.all(10),
                                  height: 70,
                                  width: 70,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        dataList[1]['AddressImage']),
                                    radius: 220,
                                  ),
                                ),
                                Container(
                                  height: 230,
                                  width: 280,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                dataList[1]['AddressName'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: HexColor('#000000')),
                                              ),
                                            ),
                                            if (PaymentStatus ==
                                                'กำลังตรวจสอบ') ...[
                                              if (dataList[0]
                                                      ['PaymentUpload'] ==
                                                  true) ...[
                                                Chip(
                                                  labelPadding:
                                                      EdgeInsets.all(2.0),
                                                  label: Icon(
                                                      Icons.payments_rounded,
                                                      color:
                                                          HexColor('#FFFFFF')),
                                                  backgroundColor:
                                                      HexColor('#F2C628'),
                                                )
                                              ],
                                              if (dataList[0]
                                                      ['PaymentUpload'] ==
                                                  false) ...[
                                                Chip(
                                                    labelPadding:
                                                        EdgeInsets.all(2.0),
                                                    label: Icon(
                                                        Icons.payments_rounded,
                                                        color: HexColor(
                                                            '#FFFFFF')),
                                                    backgroundColor:
                                                        HexColor('#AD3B3B'))
                                              ],
                                            ],
                                            if (PaymentStatus ==
                                                'เสร็จสิ้น') ...[
                                              if (dataList[0]
                                                      ['PaymentUpload'] ==
                                                  true) ...[
                                                Chip(
                                                  labelPadding:
                                                      EdgeInsets.all(2.0),
                                                  label: Icon(
                                                      Icons.payments_rounded,
                                                      color:
                                                          HexColor('#FFFFFF')),
                                                  backgroundColor:
                                                      HexColor('#1F8805'),
                                                ),
                                              ],
                                              if (dataList[0]
                                                      ['PaymentUpload'] ==
                                                  false) ...[
                                                Chip(
                                                    labelPadding:
                                                        EdgeInsets.all(2.0),
                                                    label: Icon(
                                                        Icons.payments_rounded,
                                                        color: HexColor(
                                                            '#FFFFFF')),
                                                    backgroundColor:
                                                        HexColor('#AD3B3B'))
                                              ],
                                            ],
                                            if (dataList[0]
                                                    ['HousekeeperRequest'] ==
                                                "กำลังตรวจสอบ") ...[
                                              Chip(
                                                labelPadding:
                                                    EdgeInsets.all(2.0),
                                                label: Icon(
                                                    Icons
                                                        .cleaning_services_rounded,
                                                    color: HexColor('#FFFFFF')),
                                                backgroundColor:
                                                    HexColor('#F2C628'),
                                              ),
                                            ] else if (dataList[0]
                                                    ['HousekeeperRequest'] ==
                                                "ไม่รับงาน") ...[
                                              Chip(
                                                labelPadding:
                                                    EdgeInsets.all(2.0),
                                                label: Icon(
                                                    Icons
                                                        .cleaning_services_rounded,
                                                    color: HexColor('#FFFFFF')),
                                                backgroundColor:
                                                    HexColor('#AD3B3B'),
                                              ),
                                            ] else if (dataList[0]
                                                    ['HousekeeperRequest'] ==
                                                "รับงาน") ...[
                                              Chip(
                                                labelPadding:
                                                    EdgeInsets.all(2.0),
                                                label: Icon(
                                                    Icons
                                                        .cleaning_services_rounded,
                                                    color: HexColor('#FFFFFF')),
                                                backgroundColor:
                                                    HexColor('#1F8805'),
                                              ),
                                            ],
                                          ]),
                                      Text(dataList[1]['AddressDetail'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: HexColor('#000000'))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("วันที่เลือกใช้บริการ : " +
                                          dataList[0]['DatetimeService']),
                                      Text("แพ็กเกจ : " +
                                          dataList[0]['Package']),
                                      Text("เวลาที่ใช้บริการ : " +
                                          dataList[0]['TimeStartService'] +
                                          " - " +
                                          dataList[0]['TimeEndService'] +
                                          "   ( " +
                                          dataList[0]['TimeService'] +
                                          " )"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "ผู้ให้บริการ : " +
                                                dataList[2]['FirstName'] +
                                                "   " +
                                                dataList[2]['LastName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ],
              ],
            ),
          ),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}
