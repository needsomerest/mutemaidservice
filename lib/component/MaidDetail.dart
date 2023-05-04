import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';
import 'package:mutemaidservice/screen/user/MaidScreen/MaidDetailScreen.dart';

class MaidDetail extends StatefulWidget {
  final String UserID;
  final bool fav;
  bool booked;
  bool callbymenu;

  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressData;
  final String Reservation_Day;
  final GeoPoint location_maid;
  final int distance;

  MaidDetail(
      this.UserID,
      this.fav,
      this.booked,
      this.reservationData,
      this.callbymenu,
      this.housekeeper,
      this.addressData,
      this.Reservation_Day,
      this.distance,
      this.location_maid);

  @override
  State<MaidDetail> createState() => _MaidDetailState();
}

Future<bool> checkfavhousekeeper(String userid, String favhousekeeper) async {
  return await FirebaseFirestore.instance
      .collection('User')
      .doc(userid)
      .collection('FavHousekeeper')
      .where('HousekeeperID', isEqualTo: favhousekeeper)
      .get()
      .then((value) => value.size > 0 ? true : false);
}

Future<int> sumReview(String housekeeperid) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Housekeeper')
      .doc(housekeeperid)
      .collection('Review')
      .get();
  int sum = 0;
  for (final document in querySnapshot.docs) {
    sum = sum + 1;
  }
  return sum;
}

Future<double> avgReview(String housekeeperid) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Housekeeper')
      .doc(housekeeperid)
      .collection('Review')
      .get();
  double sum = 0;
  int count = 0;
  for (final document in querySnapshot.docs) {
    final data = document.data();
    final value = data['Score'] as int;
    sum += value;
    count++;
  }
  return sum / count;
}

Future<bool> DateTimeInReservation(
    String housekeeperid, String datetimeservice, String UserID) async {
  List<Map<String, dynamic>> data = [];
  int count = 0;

  QuerySnapshot<Map<String, dynamic>> ReservationSnapshot =
      await FirebaseFirestore.instance
          .collection('User')
          .doc(UserID)
          .collection('Reservation')
          .get();
  for (QueryDocumentSnapshot<Map<String, dynamic>> ReservationDoc
      in ReservationSnapshot.docs) {
    Map<String, dynamic> ReservationData = ReservationDoc.data();

    if (ReservationData["HousekeeperID"] == housekeeperid) {
      if (ReservationData["DatetimeService"] == datetimeservice) {
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
Future<bool> CheckTimeHousekeeper(
    String housekeeperid, String reservationday) async {
  QuerySnapshot HousekeeperSnapshot = await FirebaseFirestore.instance
      .collection('Housekeeper')
      .where('HousekeeperID', isEqualTo: housekeeperid)
      .where('DateAvailable', arrayContains: reservationday)
      .get();
  if (HousekeeperSnapshot.docs.isNotEmpty) {
    return false;
  }
  return true;
}

class _MaidDetailState extends State<MaidDetail> {
  final User? user = Auth().currentUser;
  IconData icon = Icons.bookmark_border;
  IconData icon_fav = Icons.bookmark;
  bool ischeck = false;
  bool ischecktime = false;
  bool checkjob = false;
  int sumreview = 0;
  double avgreview = 0.0;

  void initState() {
    super.initState();

    avgReview(widget.housekeeper.HousekeeperID).then((result) {
      setState(() {
        avgreview = result;
      });
    });

    CheckTimeHousekeeper(
            widget.housekeeper.HousekeeperID, widget.Reservation_Day)
        .then((result) {
      setState(() {
        ischecktime = result;
      });
    });

    DateTimeInReservation(widget.housekeeper.HousekeeperID,
            widget.reservationData.DateTimeService, user!.uid)
        .then((result) {
      setState(() {
        checkjob = result;
      });
    });

    sumReview(widget.housekeeper.HousekeeperID).then((result) {
      setState(() {
        sumreview = result;
      });
    });

    checkfavhousekeeper(widget.UserID, widget.housekeeper.HousekeeperID)
        .then((result) {
      setState(() {
        ischeck = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _ischeck_distance = false;
    double different_distance = Geolocator.distanceBetween(
        widget.reservationData.AddressPoint.latitude,
        widget.reservationData.AddressPoint.longitude,
        widget.location_maid.latitude,
        widget.location_maid.longitude);

    if (widget.callbymenu == false) {
      if (different_distance <= widget.distance) {
        _ischeck_distance = true;
        // widget.housekeeper.Distance = distance.round();
      }
    } else {
      _ischeck_distance = true;
    }

    final User? user = Auth().currentUser;
    final newAddress = AddressData(
        "AddressID",
        "Addressimage",
        "Type",
        "SizeRoom",
        "Address",
        "AddressDetail",
        "Province",
        "District",
        "Phonenumber",
        "Note",
        "User",
        GeoPoint(0, 0));

    // if (ischecktime) {
    // checkjob&&
    // if (widget.callby == 'menu') {
    //   _ischeck = true;
    // }

    return Container(
      child: Column(
        children: [
          if (_ischeck_distance == true) ...[
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Container(
                  height: 300,
                  width: 380,
                  // margin: EdgeInsets.(left: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    color: HexColor('#5D5FEF').withOpacity(0.10),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(children: [
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
                            backgroundImage:
                                NetworkImage(widget.housekeeper.ProfileImage),
                            radius: 220,
                          ),
                        ),
                        Container(
                          height: 220,
                          width: 280,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.housekeeper.FirstName +
                                          "   " +
                                          widget.housekeeper.LastName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: HexColor('#000000')),
                                    ),
                                    if (ischeck == true) ...[
                                      IconButton(
                                          icon: Icon(icon_fav),
                                          color: HexColor('#5D5FEF'),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            setState(() {
                                              icon_fav = (icon_fav ==
                                                      Icons.bookmark_border)
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border;
                                              if (icon_fav == Icons.bookmark) {
                                                createfav(
                                                    user!.uid,
                                                    widget.housekeeper
                                                        .HousekeeperID);
                                              } else if (icon_fav ==
                                                  Icons.bookmark_border) {
                                                deletefav(
                                                    user!.uid,
                                                    widget.housekeeper
                                                        .HousekeeperID);
                                              }
                                            });
                                          }),
                                    ] else ...[
                                      IconButton(
                                          icon: Icon(icon),
                                          color: HexColor('#5D5FEF'),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            setState(() {
                                              icon = (icon ==
                                                      Icons.bookmark_border)
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border;
                                              if (icon == Icons.bookmark) {
                                                createfav(
                                                    user!.uid,
                                                    widget.housekeeper
                                                        .HousekeeperID);
                                              } else if (icon ==
                                                  Icons.bookmark_border) {
                                                deletefav(
                                                    user!.uid,
                                                    widget.housekeeper
                                                        .HousekeeperID);
                                              }
                                            });
                                          }),
                                    ]
                                  ]),
                              Row(children: [
                                /*Container(
                                child: Ratestar(avgreview.isNaN ? 0 : 1),
                                width: (avgreview * 20) + 10,
                                height: 50,
                              ),*/
                                Text(avgreview.isNaN
                                    ? '0'
                                    : avgreview.toString()),
                                Text(
                                  '  (' + sumreview.toString() + ' reviews)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ]),
                              Row(
                                children: [
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/icon%2Fear.png?alt=media&token=7411e8bb-f5fe-47ef-a690-03cac51c90f7",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'ระดับการได้ยิน ${widget.housekeeper.HearRanking} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/icon%2Fsyringe.png?alt=media&token=05f606b6-897f-4d5f-a199-03f36ab09cd5",
                                  height: 23,
                                  width: 23,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'รับวัคซีนป้องกันโควิด 19 จำนวน ${widget.housekeeper.Vaccinated} เข็ม',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/icon%2FmessageImage.png?alt=media&token=078c6ace-c677-4d86-8b30-dced5b8e2511",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'สื่อสารด้วย : ${widget.housekeeper.CommunicationSkill}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/icon%2Flocationpoint.png?alt=media&token=118c4a9b-568d-4bf6-a15e-183237b666e8",
                                    height: 23,
                                    width: 23,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${different_distance.toStringAsFixed(2)} กม.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    if (widget.booked == false) ...[
                      Container(
                        height: 50,
                        width: 500,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: HexColor("#5D5FEF"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            minimumSize: Size(100, 40),
                          ),
                          child: Text(
                            'จอง',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            widget.reservationData.HousekeeperID =
                                widget.housekeeper.HousekeeperID;
                            widget.reservationData.HousekeeperFirstName =
                                widget.housekeeper.FirstName;
                            widget.reservationData.HousekeeperLastName =
                                widget.housekeeper.LastName;

                            if (widget.callbymenu == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                            addressData: widget.addressData,
                                            housekeeper: widget.housekeeper,
                                            reservationData:
                                                widget.reservationData,
                                            backward: false,
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfirmInfo(
                                            reservationData:
                                                widget.reservationData,
                                            housekeeper: widget.housekeeper,
                                            booked: false,
                                            button_cancel: false,
                                            Reservation_Day:
                                                widget.Reservation_Day,
                                            maxdistance: widget.distance,
                                            addressdata: widget.addressData,
                                          )));
                            }
                          },
                        ),
                      )
                    ] else ...[
                      Divider(
                        color: HexColor(
                            '#DDDDDD'), //color of divider//height spacing of divider
                        thickness:
                            1, //thickness of divier linespacing at the end of divider
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ]
                  ])),
              onTap: () {
                /* edit here */
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MaidDetailScreen(
                              callbymenu: widget.callbymenu,
                              addressData: widget.addressData,
                              housekeeper: widget.housekeeper,
                              reservationData: widget.reservationData,
                              sumreview: sumreview,
                              avgreview: avgreview,
                              maxdistance: widget.distance,
                              reservation_day: widget.Reservation_Day,
                            )));
              },
            ),
          ]
        ],
      ),
    );
    // } else {
    //   return SizedBox();
    // }
  }

  void createfav(String uid, String housekeeper) async {
    /*  await FirebaseFirestore.instance
                              .collection('User')
                              .doc(uid)
                              .collection('Reservation')
                              .doc()
                              .set(widget.reservationData
                                  .CreateReservationtoJson());*/

    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('FavHousekeeper')
        .doc(housekeeper)
        .set({'HousekeeperID': housekeeper});
  }

  void deletefav(String uid, String HousekeeperID) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('FavHousekeeper')
        .doc(HousekeeperID)
        .delete();
  }
}
