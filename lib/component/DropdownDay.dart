import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class DropdownDay extends StatefulWidget {
  final ReservationData reservationData;
  bool callby;
  String UserID;
  DropdownDay(
      {Key? key,
      required this.reservationData,
      required this.callby,
      required this.UserID})
      : super(key: key);

  //const DropdownDay({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DropdownDay> {
  Future<List<List<dynamic>>> getAllDateAvailable() async {
    List<List<dynamic>> dataList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .where("HousekeeperID", isEqualTo: widget.reservationData.HousekeeperID)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      List<dynamic> data = documentSnapshot.get('DateAvailable');
      dataList.add(data);
    }

    return dataList;
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(UserDoc.id)
              .collection('Reservation')
              .where("HousekeeperID",
                  isEqualTo: widget.reservationData.HousekeeperID)
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> reservationDoc
          in reservationSnapshot.docs) {
        Map<String, dynamic> docData = reservationDoc.data();
        data.add(docData);
      }
    }

    return data;
  }

  DateTime _selectedDate = DateTime.now();

  // bool _isWeekday(DateTime date, List weekunavailable) {
  //   List<int> day = [];

  //   return date.weekday == 6 || date.weekday == 7 ? false : true;
  // }

  List<List<dynamic>> dataList = [];
  List<Map<String, dynamic>> reservationList = [];
  List<DateTime> datatime_reservation = [];
  List<String> dayweek = [];

  @override
  void initState() {
    super.initState();
    _getAddressFromFirebase();
  }

  Future<void> _getAddressFromFirebase() async {
    dataList = await getAllDateAvailable();
    reservationList = await getDataFromFirebase();
    if (mounted) {
      setState(() {});
    }
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    String DateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    int i = 0, j = 0;
    initializeDateFormatting('th');
    if (reservationList.isNotEmpty) {
      for (i = 0; i < reservationList.length; i++) {
        datatime_reservation.add(DateFormat('dd MMMM ค.ศ. yyyy', 'th')
            .parse(reservationList[i]['DatetimeService'].toString()));
      }
    }

    if (dataList.isNotEmpty) {
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < dataList[i].length; j++) {
          //dayweek.clear();
          dayweek.add(dataList[i][j]);
        }
      }
    }

    return Scaffold(
        body: Container(
            width: 200,
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.width / 5.5,
            child: Row(children: [
              if (widget.callby == true) ...[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: HexColor("E6E6E6"),
                    borderRadius: BorderRadius.circular(50),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       color:
                    //           Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    //       blurRadius: 5) //blur radius of shadow
                    // ]
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 130,
                    height: 50,
                    // height: 70,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: DateNow,
                        suffixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: HexColor('#000000'),
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            widget.reservationData.DateTimeService =
                                formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
              ] else ...[
                // Column(
                //   children: [
                //     for (i = 0; i < dayweek.length; i++) ...[
                //       Text(dayweek[i]),
                //     ]
                //   ],
                // )

                DecoratedBox(
                  decoration: BoxDecoration(
                    color: HexColor("E6E6E6"),
                    borderRadius: BorderRadius.circular(50),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       color:
                    //           Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    //       blurRadius: 5) //blur radius of shadow
                    // ]
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 130,
                    height: 50,
                    // height: 70,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: DateNow,
                        suffixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: HexColor('#000000'),
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          selectableDayPredicate: (DateTime date) =>
                              !datatime_reservation.contains(date) &&
                                      !dayweek.contains(
                                          DateFormat('E').format(date))
                                  ? true
                                  : false,
                        );

                        //!_disabledDays.contains(DateFormat('EEEE').format(date)) ? true : false,

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            widget.reservationData.DateTimeService =
                                formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
              ]

              // if (reservationList.isNotEmpty) ...[
              //   Column(
              //     children: [
              //       for (int i = 0; i < reservationList.length; i++) ...[
              //         Text(
              //             "${reservationList[i]['DatetimeService'].toString()}")
              //       ]
              //     ],
              //   )
              // ],
              // if (dataList.isNotEmpty) ...[
              //   for (int i = 0; i < dataList.length; i++) ...[
              //     for (int j = 0; j < dataList[i].length; j++) ...[
              //       Text('${dataList[i][j]} ,'),
              //     ]
              //   ]
              // ]
            ])));
  }
}
