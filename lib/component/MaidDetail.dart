import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/FavHousekeeperData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';
import 'package:mutemaidservice/screen/user/MaidScreen/MaidDetailScreen.dart';
import 'RateStar.dart';

class MaidDetail extends StatefulWidget {
  // const MaidDetail({super.key});
  final String UserID;
  final String HousekeeperID;
  final String FirstName;
  final String LastName;
  final String ProfileImage;
  final int HearRanking;
  final int Vaccinated;
  final int Distance;
  final String CommunicationSkill;

  final String callby;
  final bool fav;
  bool booked;
  final String PhoneNumber;

  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressData;
  final String Reservation_Day;

  MaidDetail(
      this.UserID,
      this.HousekeeperID,
      this.FirstName,
      this.LastName,
      this.ProfileImage,
      this.HearRanking,
      this.Vaccinated,
      this.Distance,
      this.CommunicationSkill,
      this.fav,
      this.booked,
      this.reservationData,
      this.callby,
      this.housekeeper,
      this.PhoneNumber,
      this.addressData,
      this.Reservation_Day);

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

    avgReview(widget.HousekeeperID).then((result) {
      setState(() {
        avgreview = result;
      });
    });

    CheckTimeHousekeeper(widget.HousekeeperID, widget.Reservation_Day)
        .then((result) {
      setState(() {
        ischecktime = result;
      });
    });

    DateTimeInReservation(widget.HousekeeperID,
            widget.reservationData.DateTimeService, widget.UserID)
        .then((result) {
      setState(() {
        checkjob = result;
      });
    });

    sumReview(widget.HousekeeperID).then((result) {
      setState(() {
        sumreview = result;
      });
    });

    checkfavhousekeeper(widget.UserID, widget.HousekeeperID).then((result) {
      setState(() {
        ischeck = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

    final newHousekeeper = FavHousekeeper(
        widget.HousekeeperID,
        widget.FirstName,
        widget.LastName,
        widget.ProfileImage,
        widget.HearRanking,
        widget.Vaccinated,
        widget.Distance,
        widget.CommunicationSkill,
        false,
        false,
        widget.PhoneNumber);

    final detailHousekeeper = Housekeeper(
        widget.HousekeeperID,
        widget.FirstName,
        widget.LastName,
        widget.ProfileImage,
        widget.HearRanking,
        widget.Vaccinated,
        widget.Distance,
        widget.CommunicationSkill,
        widget.PhoneNumber);

    if (checkjob && ischecktime) {
      return Container(
        child: Column(
          children: [
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
                            backgroundImage: NetworkImage(widget.ProfileImage),
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
                                      widget.FirstName +
                                          "   " +
                                          widget.LastName,
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
                                                    UserID, newHousekeeper);
                                              } else if (icon_fav ==
                                                  Icons.bookmark_border) {
                                                deletefav(UserID,
                                                    widget.HousekeeperID);
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
                                                    UserID, newHousekeeper);
                                              } else if (icon ==
                                                  Icons.bookmark_border) {
                                                deletefav(UserID,
                                                    widget.HousekeeperID);
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
                                    'ระดับการได้ยิน ${widget.HearRanking} ',
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
                                  'รับวัคซีนป้องกันโควิด 19 จำนวน ${widget.Vaccinated} เข็ม',
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
                                    'สื่อสารด้วย : ${widget.CommunicationSkill}',
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
                                    '${widget.Distance} กม.',
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
                                widget.HousekeeperID;
                            widget.reservationData.HousekeeperFirstName =
                                widget.FirstName;
                            widget.reservationData.HousekeeperLastName =
                                widget.LastName;

                            widget.housekeeper.HousekeeperID =
                                widget.HousekeeperID;
                            widget.housekeeper.FirstName = widget.FirstName;
                            widget.housekeeper.LastName = widget.LastName;
                            widget.housekeeper.CommunicationSkill =
                                widget.CommunicationSkill;
                            widget.housekeeper.Distance = widget.Distance;
                            widget.housekeeper.HearRanking = widget.HearRanking;
                            widget.housekeeper.ProfileImage =
                                widget.ProfileImage;
                            widget.housekeeper.Vaccinated = widget.Vaccinated;

                            if (widget.callby == 'menu') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                            addressData: newAddress,
                                            housekeeper: widget.housekeeper,
                                            reservationData:
                                                widget.reservationData,
                                            callby: true,
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
                                            callby: false,
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
                              callby: widget.callby,
                              addressData: widget.addressData,
                              PhoneNumber: widget.PhoneNumber,
                              housekeeper: detailHousekeeper,
                              reservationData: widget.reservationData,
                              sumreview: sumreview,
                              avgreview: avgreview,
                            )));
              },
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  void createfav(String uid, FavHousekeeper housekeeper) async {
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
        .doc(housekeeper.HousekeeperID)
        .set(housekeeper.CreateFavHousekeepertoJson());
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
