import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/NotificationData.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/NotificationPage.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/NotificationMaidScreen.dart';

class NotificationList extends StatefulWidget {
  bool byuser;
  String userid;
  Maid maid;
  NotificationList(this.byuser, this.userid, this.maid);
  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  Future<void> updateNotificationStatus(String notificaitonid) async {
    try {
      await FirebaseFirestore.instance
          .collection('Notification')
          .doc(notificaitonid)
          .update({
        'Seen': true, // Set the 'isSeen' field to true
      });
    } catch (e) {
      print('Error updating notification status: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Scaffold(
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Notification")
                      .where("UserID", isEqualTo: widget.userid)
                      .where('Seen', isEqualTo: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                        'ยังไม่มีรายการ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ));
                    } else {
                      if (widget.byuser == true) {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot NotificationDocument) {
                            Map<String, dynamic> data =
                                NotificationDocument.data()!
                                    as Map<String, dynamic>;
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: data['Seen'] == true
                                  ? HexColor('#EEEEEE')
                                  : HexColor('#C5C5F9'),
                              title: Text(data['Header']),
                              subtitle: Text(data['NotificationDetail']),
                              onTap: () {
                                if (data['Seen'] == false) {
                                  updateNotificationStatus(
                                      NotificationDocument.id);
                                }
                                final newnotificationdata =
                                    new NotificationData(
                                  data['UserID'],
                                  data['ReservationID'],
                                  data['NotificationDetail'],
                                  data['Header'],
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotificationScreen(
                                            notificationdata:
                                                newnotificationdata,
                                          )),
                                );
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot NotificationDocument) {
                            Map<String, dynamic> data =
                                NotificationDocument.data()!
                                    as Map<String, dynamic>;
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: data['Seen'] == true
                                  ? HexColor('#EEEEEE')
                                  : HexColor('#C5C5F9'),
                              title: Text(data['Header']),
                              subtitle: Text(data['NotificationDetail']),
                              onTap: () {
                                if (data['Seen'] == false) {
                                  updateNotificationStatus(
                                      NotificationDocument.id);
                                }
                                final newnotificationdata =
                                    new NotificationData(
                                  data['UserID'],
                                  data['ReservationID'],
                                  data['NotificationDetail'],
                                  data['Header'],
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationMaidScreen(
                                              notificationdata:
                                                  newnotificationdata,
                                              maid: widget.maid)),
                                );
                              },
                            );
                          }).toList(),
                        );
                      }
                    }
                  }),
            ),
          ),
        ),
      );
}
