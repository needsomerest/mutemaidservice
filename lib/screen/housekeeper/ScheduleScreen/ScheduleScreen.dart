// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/ChatMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import '../HomeScreen/HomeMaidScreen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late String userId;
  late String BookingId;

  Future<void> updateReserve({
    required String status,
  }) async {
    try {
      final docMaid = await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Reservation')
          .doc(BookingId)
          .update({
        'Status': status,
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future UpdateReservationDetail(String DateTimePackage, String Package,
      String UserID, String BookingID) async {
    if (Package == "รายครั้ง") {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(UserID)
          .collection("Reservation")
          .doc(BookingID)
          .update({"Status": "เสร็จสิ้น"});
    } else if (Package == "รายเดือน") {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(UserID)
          .collection("Reservation")
          .doc(BookingID)
          .update({"DatetimeService": DateTimePackage});
    } else if (Package == "รายสัปดาห์") {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(UserID)
          .collection("Reservation")
          .doc(BookingID)
          .update({"DatetimeService": DateTimePackage});
    } else if (Package == "รายวัน") {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(UserID)
          .collection("Reservation")
          .doc(BookingID)
          .update({"DatetimeService": DateTimePackage});
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  String? Date;

  Map<String, List> mySelectedEvents = {};

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];
    final HousekeeperID = "9U9xNdySRx475ByRhjBw";
    await initializeDateFormatting('th_TH', null);
    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    print('Number of User documents: ${UserSnapshot.size}');

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> reserveSnapshot =
          await FirebaseFirestore.instance
              .collection("User")
              .doc(UserDoc.id)
              .collection('Reservation')
              .where('HousekeeperID', isEqualTo: HousekeeperID)
              .where('HousekeeperRequest', isEqualTo: "รับงาน")
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> reserveDoc
          in reserveSnapshot.docs) {
        String addressID = reserveDoc.data()['AddressID'];
        DocumentSnapshot<Map<String, dynamic>> addressSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .collection('Address')
                .doc(addressID)
                .get();
        print(
            'Number of User documents with id=$addressID : ${addressSnapshot.data()}');

        Map<String, dynamic> reserveData = reserveDoc.data();
        Map<String, dynamic>? addressData = addressSnapshot.data();
        Map<String, dynamic> mergedData = {};
        reserveData['ReservationId'] = reserveDoc.id;
        DateTime dateTime = DateFormat('d MMMM ค.ศ. yyyy', 'th_TH')
            .parse(reserveData['DatetimeService']);
        reserveData['Date'] = dateTime;
        reserveData['UserID'] = UserDoc.id;
        // print(${dateTime});
        print(
            'Number of Reserve documents with id=${reserveData['ReservationId']} | date: ${reserveData['Date']}');

        mergedData.addAll(reserveData);
        if (addressData != null) {
          mergedData.addAll(addressData);
        }
        data.add(mergedData);
      }
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    _getDataFromFirebase();
  }

  List<Map<String, dynamic>> dataList = [];
  // String date = "";
  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    loadPreviousEvents(); // set the minute to run the function every day// the function to run every day
    DateTime now = DateTime.now();
    // DateTime now = DateTime.parse('2023-04-17 00:00:00');
    print(now);
    TimeOfDay midnight = TimeOfDay(hour: 0, minute: 0);
    if (TimeOfDay.fromDateTime(now) == midnight) {
      resetStatus();
      // Do something
    }

    setState(() {});
    // print(dataList);
  }

  resetStatus() {
    for (var i = 0; i < dataList.length; i++) {
      DateTime dateTime = dataList[i]['Date'];
      DateTime today = DateTime.now();
      // final tomorrow =
      //         DateTime(dateTime.year, dateTime.month, dateTime.day+1);
      if (dataList[i]['Package'] == "รายเดือน") {
        for (int j = 0; j < 12; j++) {
          final eventmonthFirst =
              DateTime(dateTime.year, dateTime.month + j, dateTime.day);
          bool isToday = eventmonthFirst.month == today.month &&
              eventmonthFirst.day == today.day;
          try {
            print("date: ${eventmonthFirst.toString()}");
            if ((isToday)) {
              //eventmonthFirst.isAfter(DateTime.now())
              setState(() {
                userId = dataList[i]['UserID'];
                BookingId = dataList[i]['ReservationId'];
              });
              updateReserve(
                status: 'กำลังมาถึง',
              ).then((value) {
                print('Maid updated successfully!');
              }).catchError((error) {
                print('Error updating Maid: $error');
              });
              break;
            }
          } catch (e) {
            print(e);
            // Handle the exception here
          }
        }
      }
      if (dataList[i]['Package'] == "รายสัปดาห์") {
        for (int j = 0; j < 365; j += 7) {
          final eventmonthFirst =
              DateTime(dateTime.year, dateTime.month, dateTime.day + j);
          bool isToday = eventmonthFirst.month == today.month &&
              eventmonthFirst.day == today.day;
          try {
            print("date: ${eventmonthFirst.toString()}");
            if (isToday) {
              setState(() {
                userId = dataList[i]['UserID'];
                BookingId = dataList[i]['ReservationId'];
              });
              updateReserve(
                status: 'กำลังมาถึง',
              ).then((value) {
                print('Maid updated successfully!');
              }).catchError((error) {
                print('Error updating Maid: $error');
              });
              break;
            }
          } catch (e) {
            print(e);
            // Handle the exception here
          }
        }
      }
      if (dataList[i]['Package'] == "รายวัน") {
        for (int j = 0; j < 365; j++) {
          final eventmonthFirst =
              DateTime(dateTime.year, dateTime.month, dateTime.day + j);
          bool isToday = eventmonthFirst.month == today.month &&
              eventmonthFirst.day == today.day;
          try {
            print("date: ${eventmonthFirst.toString()}");
            if (isToday) {
              setState(() {
                userId = dataList[i]['UserID'];
                BookingId = dataList[i]['ReservationId'];
              });
              updateReserve(
                status: 'กำลังมาถึง',
              ).then((value) {
                print('Maid updated successfully!');
              }).catchError((error) {
                print('Error updating Maid: $error');
              });
              break;
            }
          } catch (e) {
            print(e);
            // Handle the exception here
          }
        }
      }
    }
  }

  loadPreviousEvents() {
    print("Data: ${dataList.length}");
    for (int i = 0; i < dataList.length; i++) {
      // DateTime dateTime = dataList[i]['Date'];
      setState(() {
        if (dataList[i]['Package'] == "ครั้งเดียว") {
          if (mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(dataList[i]['Date']!)] !=
              null) {
            mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(dataList[i]['Date']!)]
                ?.add({
              "AdressName": dataList[i]['AddressName'],
              "Time": dataList[i]['TimeStartService'],
              "ReserveID": dataList[i]['ReservationId'],
              "UserID": dataList[i]['UserID'],
              "Package": dataList[i]['Package'],
              "DateTimeService": dataList[i]['DatetimeService'],
            });
          } else {
            mySelectedEvents[
                DateFormat('yyyy-MM-dd').format(dataList[i]['Date']!)] = [
              {
                "AdressName": dataList[i]['AddressName'],
                "Time": dataList[i]['TimeStartService'],
                "ReserveID": dataList[i]['ReservationId'],
                "UserID": dataList[i]['UserID'],
                "Package": dataList[i]['Package'],
                "DateTimeService": dataList[i]['DatetimeService'],
              }
            ];
          }
        }
        if (dataList[i]['Package'] == "รายเดือน") {
          for (int j = 0; j < 12; j++) {
            final DateTime eventmonth = dataList[i]['Date'];
            final eventmonthFirst =
                DateTime(eventmonth.year, eventmonth.month + j, eventmonth.day);

            if (mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(eventmonthFirst)] !=
                null) {
              mySelectedEvents[DateFormat('yyyy-MM-dd').format(eventmonthFirst)]
                  ?.add({
                "AdressName": dataList[i]['AddressName'],
                "Time": dataList[i]['TimeStartService'],
                "ReserveID": dataList[i]['ReservationId'],
                "UserID": dataList[i]['UserID'],
                "Package": dataList[i]['Package'],
                "DateTimeService": dataList[i]['DatetimeService'],
              });
            } else {
              mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(eventmonthFirst)] = [
                {
                  "AdressName": dataList[i]['AddressName'],
                  "Time": dataList[i]['TimeStartService'],
                  "ReserveID": dataList[i]['ReservationId'],
                  "UserID": dataList[i]['UserID'],
                  "Package": dataList[i]['Package'],
                  "DateTimeService": dataList[i]['DatetimeService'],
                }
              ];
            }
          }
        }
        if (dataList[i]['Package'] == "รายสัปดาห์") {
          for (int j = 0; j < 365; j += 7) {
            final DateTime eventmonth = dataList[i]['Date'];
            final eventmonthFirst =
                DateTime(eventmonth.year, eventmonth.month, eventmonth.day + j);
            if (mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(eventmonthFirst)] !=
                null) {
              mySelectedEvents[DateFormat('yyyy-MM-dd').format(eventmonthFirst)]
                  ?.add({
                "AdressName": dataList[i]['AddressName'],
                "Time": dataList[i]['TimeStartService'],
                "ReserveID": dataList[i]['ReservationId'],
                "UserID": dataList[i]['UserID'],
                "Package": dataList[i]['Package'],
                "DateTimeService": dataList[i]['DatetimeService'],
              });
            } else {
              mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(eventmonthFirst)] = [
                {
                  "AdressName": dataList[i]['AddressName'],
                  "Time": dataList[i]['TimeStartService'],
                  "ReserveID": dataList[i]['ReservationId'],
                  "UserID": dataList[i]['UserID'],
                  "Package": dataList[i]['Package'],
                  "DateTimeService": dataList[i]['DatetimeService'],
                }
              ];
            }
          }
        }
        if (dataList[i]['Package'] == "รายวัน") {
          for (int j = 0; j < 365; j++) {
            final DateTime eventmonth = dataList[i]['Date'];
            final eventmonthFirst =
                DateTime(eventmonth.year, eventmonth.month, eventmonth.day + j);
            if (mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(eventmonthFirst)] !=
                null) {
              mySelectedEvents[DateFormat('yyyy-MM-dd').format(eventmonthFirst)]
                  ?.add({
                "AdressName": dataList[i]['AddressName'],
                "Time": dataList[i]['TimeStartService'],
                "ReserveID": dataList[i]['ReservationId'],
                "UserID": dataList[i]['UserID'],
                "Package": dataList[i]['Package'],
                "DateTimeService": dataList[i]['DatetimeService'],
              });
            } else {
              mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(eventmonthFirst)] = [
                {
                  "AdressName": dataList[i]['AddressName'],
                  "Time": dataList[i]['TimeStartService'],
                  "ReserveID": dataList[i]['ReservationId'],
                  "UserID": dataList[i]['UserID'],
                  "Package": dataList[i]['Package'],
                  "DateTimeService": dataList[i]['DatetimeService'],
                }
              ];
            }
          }
        }
      });
    }
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    int _selectedIndex = 1;
    final screens = [
      HomeMaidScreen(),
      ScheduleScreen(),
      ChatMaidScreen(),
    ];
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 6, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 6, kToday.day);
    initializeDateFormatting('th_TH');
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
        title: Text('ตารางงาน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          width: double.infinity,
          // alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TableCalendar(
                locale: 'th_TH',
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDate, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                eventLoader: _listOfDayEvents,
              ),
              ..._listOfDayEvents(_selectedDate!).map(
                (myEvents) => Container(
                  child: ListTile(
                      title: Container(
                          margin: const EdgeInsets.symmetric(
                            // horizontal: 12.0,
                            vertical: 15.0,
                          ),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: HexColor('#BDBDBD').withOpacity(0.15),
                            border: Border(
                                left: BorderSide(
                                    color: HexColor('#5D5FEF'), width: 5)),
                            // border: Border.all(),
                            // borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(_focusedDay.day.toString(),
                                          style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#5D5FEF'))),
                                      Text(
                                          DateFormat.MMM('th_TH')
                                              .format(_focusedDay),
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#5D5FEF'))),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/location.png",
                                            height: 35,
                                            width: 35,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("${myEvents['AdressName']}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor('#5D5FEF'))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/clock.png",
                                            height: 35,
                                            width: 35,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("${myEvents['Time']} น.",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor('#949191'))),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 30,
                                    margin: EdgeInsets.only(left: 10),
                                    child: TextButton(
                                      child: Icon(
                                        Icons.navigate_next,
                                        size: 30,
                                        color: HexColor('#5D5FEF'),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JobDetailScreen(
                                                        myEvents['ReserveID'],
                                                        true,
                                                        DateFormat.yMMMMd(
                                                                'th_TH')
                                                            .format(_focusedDay)
                                                            .toString())));

                                        // print("${myEvents['ReserveID']}");
                                      },
                                    ),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: HexColor('#5D5FEF'),
                                          width: 2)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: Icon(
                                        Icons.work_history,
                                        size: 40,
                                        color: HexColor('#5D5FEF'),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          userId = myEvents['UserID'];
                                          BookingId = myEvents['ReserveID'];
                                        });
                                        updateReserve(
                                          status: 'กำลังดำเนินการ',
                                        ).then((value) {
                                          print('Maid updated successfully!');
                                        }).catchError((error) {
                                          print('Error updating Maid: $error');
                                        });
                                      },
                                    ),
                                    TextButton(
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        size: 40,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          userId = myEvents['UserID'];
                                          BookingId = myEvents['ReserveID'];
                                        });
                                        String DateTimePackage = '';
                                        DateTime dateTime = DateFormat(
                                                'dd MMMM ค.ศ. yyyy', 'th')
                                            .parse(myEvents['DateTimeService']);

                                        if (myEvents['Package'] == "รายเดือน") {
                                          DateTime nextMonth = DateTime(
                                              dateTime.year,
                                              dateTime.month + 1,
                                              dateTime.day);
                                          DateTimePackage = DateFormat(
                                                  'dd MMMM ค.ศ. yyyy', 'th')
                                              .format(nextMonth);
                                        }

                                        if (myEvents['Package'] ==
                                            "รายสัปดาห์") {
                                          DateTime nextWeek = DateTime(
                                              dateTime.year,
                                              dateTime.month,
                                              dateTime.day + 7);
                                          DateTimePackage = DateFormat(
                                                  'dd MMMM ค.ศ. yyyy', 'th')
                                              .format(nextWeek);
                                        }

                                        if (myEvents['Package'] == "รายวัน") {
                                          DateTime nextDay = DateTime(
                                              dateTime.year,
                                              dateTime.month,
                                              dateTime.day + 1);
                                          DateTimePackage = DateFormat(
                                                  'dd MMMM ค.ศ. yyyy', 'th')
                                              .format(nextDay);
                                        }
                                        ;
                                        UpdateReservationDetail(
                                            DateTimePackage,
                                            myEvents['Package'],
                                            UserID,
                                            myEvents['ReserveID']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeMaidScreen()));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'หน้าหลัก',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.calendar,
                  text: 'ตารางงาน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'ข้อความ',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screens[_selectedIndex]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
