import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/MyBooking.dart';

import '../UserScreen/Signup/SignupScreen.dart';

class ReviewScreen extends StatefulWidget {
  ReservationData reservationData;
  Housekeeper housekeeper;
  ReviewScreen(
      {Key? key, required this.reservationData, required this.housekeeper})
      : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 3;
  final TextEditingController _controllersReviewDetail =
      TextEditingController();
  final User? user = Auth().currentUser;

  Future AddReview({
    required String housekeeperid,
    required String reservationid,
    required String userid,
    required String datetimereview,
    required int ratting,
    required String reviewdetail,
  }) async {
    final docUser = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(housekeeperid)
        .collection('Review')
        .doc();

    final ReviewTojson = {
      'ReservationID': reservationid,
      'UserID': userid,
      'DateTimeReview': datetimereview,
      'Score': ratting,
      'ReviewDetail': reviewdetail,
    };
    await docUser.set(ReviewTojson);
  }

  Future UpdateReservationStatus({
    required String useruid,
    required String reservationid,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .doc(useruid)
        .collection('Reservation')
        .doc(reservationid)
        .update({
      'Status': 'ประวัติ',
    }).then((result) {
      print("Update Status true");
    }).catchError((onError) {
      print("onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    final userid = user?.uid;

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
        title: Text('รีวิวบริการจากแม่บ้าน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 730,
          width: double.infinity,
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                // margin: EdgeInsets.only(top: 30),
                height: 720,
                decoration: BoxDecoration(
                    color: HexColor('#FFFFFF'),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedboxHeaderForm("รายละเอียดการจอง : "),
                      Container(
                        height: 260,
                        width: 400,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: HexColor('#5D5FEF').withOpacity(0.2),
                          border: Border.all(
                              width: 1.5, color: HexColor('#5D5FEF')),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ที่อยู่ที่รับบริการ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#979797')),
                            ),
                            Text(
                              widget.reservationData.addressDetail,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#000000')),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ข้อมูลงาน',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#979797')),
                            ),
                            Flexible(
                                child: Row(
                              children: [
                                Text(
                                  "วันที่รับบริการ : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#000000')),
                                ),
                                Text(
                                  widget.reservationData.DateTimeService,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#000000')),
                                ),
                              ],
                            )),
                            Text(
                              "เวลาที่เลือกใช้บริการ : " +
                                  widget.reservationData.TimeStartService +
                                  " - " +
                                  widget.reservationData.TimeEndService +
                                  " (" +
                                  widget.reservationData.Timeservice +
                                  ")",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#000000')),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ผู้ให้บริการ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#979797')),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.housekeeper.ProfileImage.isEmpty
                                          ? "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c"
                                          : widget.housekeeper.ProfileImage,
                                    ),
                                    radius: 20,
                                  ),
                                  Text(
                                    "     " +
                                        widget.housekeeper.FirstName +
                                        "   " +
                                        widget.housekeeper.LastName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#000000')),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedboxHeaderForm("คะแนนรีวิว : "),
                      Center(
                        child: RatingBar.builder(
                          initialRating: _rating.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: HexColor("#5D5FEF"),
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating.round();
                            });
                          },
                        ),
                      ),
                      SizedboxHeaderForm("รายละเอียด : "),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        cursorColor: HexColor("#5D5FEF"),
                        textAlign: TextAlign.left,
                        minLines: 6,
                        maxLines: 10,
                        controller: _controllersReviewDetail,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                            hintText:
                                ' เพิ่มรายละเอียดเพื่อรีวิวการทำงานของแม่บ้าน',
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                              ),
                            ),
                            filled: true,
                            fillColor: HexColor("#DFDFFC"),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: HexColor("#5D5FEF"),

                                //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
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
                            'ยืนยันการรีวิว',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            UpdateReservationStatus(
                                useruid: userid.toString(),
                                reservationid:
                                    widget.reservationData.BookingID);
                            final now = DateTime.now();
                            final formatter = DateFormat('dd/MM/yyyy');
                            AddReview(
                                housekeeperid:
                                    widget.reservationData.HousekeeperID,
                                reservationid: widget.reservationData.BookingID,
                                userid: userid.toString(),
                                datetimereview:
                                    formatter.format(now).toString(),
                                ratting: _rating,
                                reviewdetail: _controllersReviewDetail.text);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyBooking()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //  Text("Full Name: ${data['PhoneNumber']}");
  }
}
