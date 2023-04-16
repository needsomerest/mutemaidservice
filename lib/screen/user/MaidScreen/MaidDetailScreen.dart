import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/RateStar.dart';
import 'package:mutemaidservice/component/ReviewList.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmInfoScreen.dart';

class MaidDetailScreen extends StatefulWidget {
  final String callby;
  final String PhoneNumber;
  final ReservationData reservationData;
  final AddressData addressData;
  final Housekeeper housekeeper;
  int sumreview;
  double avgreview;

  MaidDetailScreen(
      {Key? key,
      required this.callby,
      required this.PhoneNumber,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper,
      required this.sumreview,
      required this.avgreview})
      : super(key: key);
  bool star = false;

  @override
  State<MaidDetailScreen> createState() => _MaidDetailScreenState();
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

class _MaidDetailScreenState extends State<MaidDetailScreen> {
  int sumreview = 0;
  final List<String> _filters = <String>[''];
  List<String> title = [
    "ทั้งหมด",
    "5",
    "4",
    "3",
    "2",
    "1",
  ];
  void initState() {
    super.initState();
    sumReview(widget.housekeeper.HousekeeperID).then((result) {
      setState(() {
        sumreview = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FilterChip> filterhints = title.map((item) {
      return FilterChip(
        selectedColor: HexColor('5D5FEF'),
        avatar: _filters.contains(item)
            ? Icon(Icons.star, color: Colors.white)
            : Icon(Icons.star, color: HexColor('5D5FEF')),
        backgroundColor: HexColor('DFDFFC'),
        showCheckmark: false,
        label: Text(item),
        labelStyle: _filters.contains(item)
            ? TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)
            : TextStyle(
                color: HexColor('5D5FEF'),
                fontSize: 12,
                fontWeight: FontWeight.bold),
        selected: _filters.contains(item),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              if (!_filters.contains(item)) {
                _filters.clear();
                _filters.add(item);
              }
            } else {
              _filters.removeWhere((String name) {
                return name == item;
              });
            }
          });
        },
      );
    }).toList();

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: 1180,
                width: 800,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.network(
                      widget.housekeeper.ProfileImage,
                      height: 340,
                    ),
/*
                    Image.asset(
                      "assets/images/profilemaid.jpg",
                      height: 340,
                    ),*/
                    Container(
                      height: 300,
                      width: 400,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.housekeeper.FirstName +
                                    "  " +
                                    widget.housekeeper.LastName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: HexColor('#000000')),
                              ),
                              /*if (widget.fav == true) ...[
                                Icon(
                                  Icons.bookmark,
                                  color: HexColor('#5D5FEF'),
                                  size: 30.0,
                                ),
                              ] else ...[
                                Icon(
                                  Icons.bookmark_border,
                                  color: HexColor('#5D5FEF'),
                                  size: 30.0,
                                ),
                              ]*/
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.avgreview.isNaN
                                  ? '0'
                                  : widget.avgreview.toString()),
                              Text(
                                '  (' + sumreview.toString() + ' reviews)',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
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
                                  fontWeight: FontWeight.w500, fontSize: 16),
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/locationpoint.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  '126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/phone-call.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.PhoneNumber,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: HexColor('#DDDDDD')),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        if (widget.avgreview.isNaN) ...[
                          Container(
                            margin: EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/star.png",
                                      height: 32,
                                      width: 32,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.avgreview.isNaN
                                          ? '0'
                                          : widget.avgreview.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      '  (' +
                                          sumreview.toString() +
                                          ' reviews)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.topCenter,
                                child: Wrap(
                                  spacing: 8.0,
                                  children: filterhints,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                          Container(
                            height: 200,
                            width: 400,
                            alignment: Alignment.center,
                            child: Text(
                              'ยังไม่มีรายการรีวิว',
                              style: TextStyle(
                                  fontSize: 18, color: HexColor('CDCDCD')),
                            ),
                          )
                        ] else ...[
                          Container(
                            margin: EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/star.png",
                                      height: 32,
                                      width: 32,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.avgreview.isNaN
                                          ? '0'
                                          : widget.avgreview.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      '  (' +
                                          sumreview.toString() +
                                          ' reviews)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.topCenter,
                                child: Wrap(
                                  spacing: 8.0,
                                  children: filterhints,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                          ReviewList(widget.housekeeper.HousekeeperID,
                              _filters.first.toString()),
                        ]
                      ],
                    ),

                    /* Container(
                      height: 60,
                      width: 600,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => Container(
                                height: 50,
                                width: 100,
                                child: Center(
                                  child: StarButton(
                                    widget.title[index],
                                    35,
                                    85,
                                    18,
                                    16,
                                    widget.star,
                                  ),
                                ),
                              ))),
                    ),*/

                    // Row(
                    //   children: [
                    //     StarButton("ทั้งหมด", 35, 85, 18, 16, true),
                    //     StarButton("5", 35, 85, 18, 16, false),
                    //     StarButton("4", 35, 85, 18, 16, false),
                    //     StarButton("3", 35, 85, 18, 16, false),
                    //     // InkWell(
                    //     //   child: StarButton(
                    //     //       "ทั้งหมด", 35, 85, 18, 16, true),
                    //     //   onTap: (() {
                    //     //     setState(() {
                    //     //       widget.star = true;
                    //     //     });
                    //     //   }),
                    //     // ),
                    //   ],
                    // ),

                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 20, top: 30),
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

                          if (widget.callby == 'menu') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingScreen(
                                          addressData: widget.addressData,
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

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmInfo(
                                        booked: false,
                                        housekeeper: widget.housekeeper,
                                        reservationData: widget.reservationData,
                                        callby: false,
                                      )));
                        },
                      ),
                    )
                  ],
                ))));
  }
}
