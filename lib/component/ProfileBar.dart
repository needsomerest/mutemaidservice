import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/NotificationList.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/NotificationPage.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/MenuScreen.dart';
import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;

Stream<int> countDocuments(String userid) {
  return FirebaseFirestore.instance
      .collection('Notification')
      .where('UserID', isEqualTo: userid)
      .where('Seen', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.size);
}

class ProfileBar extends StatelessWidget {
  final User? user = Auth().currentUser;
  final maid =
      new Maid("HousekeeperID", "FirstName", "LastName", "ProfileImage");
  int notification_count = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: HexColor("#5D5FEF"),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Container(
                                // alignment: Alignment.topCenter,
                                // margin: EdgeInsets.only(botto),
                                margin: EdgeInsets.only(bottom: 20),
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user?.photoURL ??
                                        "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/download%20(4).jpg?alt=media&token=312d915c-b0ac-4b11-880a-67610ffd06ce",
                                  ),
                                  radius: 220,
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 20),https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/download%20(4).jpg?alt=media&token=312d915c-b0ac-4b11-880a-67610ffd06ce
                              //   child: Image.network(
                              //     user?.photoURL ??
                              //         "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/download%20(4).jpg?alt=media&token=312d915c-b0ac-4b11-880a-67610ffd06ce",
                              //     //photoURL
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top: 30),
                                      child: Text('ยินดีต้อนรับ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    Container(
                                        // margin: EdgeInsets.only(top: 10),
                                        width: 150,
                                        child: Flexible(
                                          child:
                                              Text(user?.displayName ?? 'User',
                                                  style: TextStyle(
                                                    // TextStyle(fontFamily: 'Itim', fontSize: 20),
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                        ),

                        StreamBuilder<int>(
                          stream: countDocuments(user!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return IconButton(
                                icon: badges.Badge(
                                  badgeContent: Text(
                                    "${snapshot.data}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  badgeColor: Colors.redAccent,
                                  showBadge: snapshot.data == 0 ? false : true,
                                  child: Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationList(
                                                  true, user!.uid, maid)));
                                  // NotificationScreen()));

                                  // Handle button press
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),

                        // InkWell(
                        //   child: Container(
                        //     // margin: EdgeInsets.only(right: 5),
                        //     padding: const EdgeInsets.only(
                        //         left: 30, right: 10, bottom: 20),

                        //     child: Icon(
                        //       Icons.notifications_none,
                        //       color: Colors.white,
                        //       size: 35,
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 NotificationScreen()));
                        //     // NotificationScreen()));
                        //   },
                        // )
                      ],
                    )),
              ),
            ],
          ),
        ),
      );
}
