import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/NotificationPage.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/ProfileMaidScreen.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/MenuScreen.dart';

class ProfileMaidBar extends StatelessWidget {
  final User? user = Auth().currentUser;
  String FirstName;
  String LastName;
  String ProfileImg;
  String HousekeeperID;
  ProfileMaidBar(
      this.FirstName, this.LastName, this.ProfileImg, this.HousekeeperID);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            // margin: EdgeInsets.only(botto),
                            // margin: EdgeInsets.only(bottom: 20),
                            height: 70,
                            width: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                this.ProfileImg,
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
                                child:
                                    Text("${this.FirstName} ${this.LastName}",
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
                                builder: (context) => ProfileMaidScreen()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        // margin: EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.only(
                            left: 30, right: 10, bottom: 20),
                        child: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                        // GetUserData()));
                      },
                    )
                  ],
                )),
          ),
          //   ],
          // ),
        ),
      );
}
