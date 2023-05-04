import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/NotificationList.dart';
import 'package:mutemaidservice/model/Data/NotificationData.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/model/notification_managet.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';

class NotificationMaidScreen extends StatefulWidget {
  NotificationData notificationdata;
  Maid maid;

  NotificationMaidScreen({required this.notificationdata, required this.maid});

  @override
  State<NotificationMaidScreen> createState() => _NotificationMaidScreenState();
}

class _NotificationMaidScreenState extends State<NotificationMaidScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeMaidScreen(maid: widget.maid)));
          },
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
                Text(
                  "${widget.notificationdata.ReservationID}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: HexColor('#5D5FEF')),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/money.png",
                        height: 100,
                        width: 100,
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 80,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Container(
          //   height: 50,
          //   width: 500,
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(right: 20, top: 30),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       alignment: Alignment.center,
          //       backgroundColor: HexColor("#5D5FEF"),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40.0),
          //       ),
          //       minimumSize: Size(100, 40),
          //     ),
          //     child: Text(
          //       'Simple Notification',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onPressed: () {
          //       NotificationManager().simpleNotificationShow();
          //     },
          //   ),
          // ),
          // Container(
          //   height: 50,
          //   width: 500,
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(right: 20, top: 30),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       alignment: Alignment.center,
          //       backgroundColor: HexColor("#5D5FEF"),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40.0),
          //       ),
          //       minimumSize: Size(100, 40),
          //     ),
          //     child: Text(
          //       'Big Picture Notification',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onPressed: () {
          //       NotificationManager().bigPictureNotificationShow();
          //     },
          //   ),
          // ),
          // Container(
          //   height: 50,
          //   width: 500,
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(right: 20, top: 30),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       alignment: Alignment.center,
          //       backgroundColor: HexColor("#5D5FEF"),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40.0),
          //       ),
          //       minimumSize: Size(100, 40),
          //     ),
          //     child: Text(
          //       "Multiple Notification",
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onPressed: () {
          //       NotificationManager().multipleNotificationShow();
          //     },
          //   ),
          // )
          // Text(
          //   'ยังไม่มีรายการ',
          //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          // ),

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
