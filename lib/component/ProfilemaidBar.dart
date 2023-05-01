import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/NotificationList.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/NotificationPage.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/ProfileMaidScreen.dart';
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

class ProfileMaidBar extends StatelessWidget {
  final Maid maid;
  bool byuser;

  ProfileMaidBar(
      {Key? key,
      required this.maid,
      required this.byuser}) //required this.addressData
      : super(key: key);

  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        // ),
        body: SingleChildScrollView(
          child:
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              Container(
            height: 150,
            decoration: BoxDecoration(
                color: HexColor("#5D5FEF"),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Container(
                margin: EdgeInsets.only(left: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            // margin: EdgeInsets.only(botto),
                            // margin: EdgeInsets.only(bottom: 20),
                            height: 70,
                            width: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                this.maid.ProfileImage,
                              ),
                              radius: 220,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 20, top: 20),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          Container(
                              // margin: EdgeInsets.only(top: 15),
                              width: 150,
                              child: Flexible(
                                child: Text(
                                    "${this.maid.FirstName} ${this.maid.LastName}",
                                    // user?.displayName ?? 'User',
                                    style: TextStyle(
                                      // TextStyle(fontFamily: 'Itim', fontSize: 20),
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileMaidScreen(
                                      maid: this.maid,
                                    )));
                      },
                    ),
                    StreamBuilder<int>(
                      stream: countDocuments(this.maid.HousekeeperID),
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
                                      builder: (context) => NotificationList(
                                          false, this.maid.HousekeeperID)));
                              // NotificationScreen()));

                              // Handle button press
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                )),
          ),
          //   ],
          // ),
        ),
      );
}
