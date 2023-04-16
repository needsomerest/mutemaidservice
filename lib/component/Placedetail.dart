import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/CardPromotion.dart';

class PlaceDetail extends StatefulWidget {
  // const PlaceDetail({super.key});
  String BookingID;
  PlaceDetail(this.BookingID);
  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    // final UserID = FirebaseFirestore.instance.collection("TestUser").doc(UserID);
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc("EjrH3vIPBAdtuMBBTpTXmzb0Pil2")
                .collection('Reservation')
                // .where('Reservation.id', isEqualTo: widget.BookingID)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return
                    /*Container(
                  height: 100,
                  width: 400,
                  // margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.all(20),
                  // color: HexColor('#BDBDBD').withOpacity(0.25),
                  decoration: BoxDecoration(
                      color: HexColor('#BDBDBD').withOpacity(0.25),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/woman.png",
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "พิชญาภรณ์ หัสเมตโต", //"${UserDocument['FirstName']} ${UserDocument['LastName']}" UserDocument['PhoneNumber']
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Text("0995935451",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ));*/
                    ListView(
                  // scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((UserDocument) {
                    return Text('${UserDocument['FirstName']}');
                    /*Container(
                      height: 100,
                      width: 400,
                      // margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.all(20),
                      // color: HexColor('#BDBDBD').withOpacity(0.25),
                      decoration: BoxDecoration(
                          color: HexColor('#BDBDBD').withOpacity(0.25),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/woman.png",
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "พิชญาภรณ์ หัสเมตโต", //"${UserDocument['FirstName']} ${UserDocument['LastName']}" UserDocument['PhoneNumber']
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Text("0995935451",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ));*/
                    // Text(UserDocument["PhoneNumber"]);
                  }).toList(),
                );
              }
            }));
  }
}




  //   Scaffold(
  //       body: StreamBuilder(
  //           stream: FirebaseFirestore.instance
  //               .collection("TestUser")
  //               .doc("VLuqvSDyTI6P6f6ym08Z")
  //               .collection("AddressTest")
  //               .snapshots(),
  //               // .collection("Booking")
  //               // .where("BookingID", isEqualTo: widget.BookingID)
  //               // .snapshots(),
  //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //             //snapshots()
  //             if (!snapshot.hasData) {
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             } else {
  //               snapshot.data!.docs.map((WhereAddress) {
  //                 AddressID = WhereAddress["AddressID"].toString();
  //               });

  //               return Scaffold(
  //                 body: StreamBuilder(
  //                   stream: FirebaseFirestore.instance
  //                       .collection("Address")
  //                       .where("AddressID", isEqualTo: AddressID)
  //                       .snapshots(),
  //                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //                     if (!snapshot.hasData) {
  //                       return Center(
  //                         child: CircularProgressIndicator(),
  //                       );
  //                     } else {
  //                       return ListView(
  //                         children: snapshot.data!.docs.map(
  //                           (AddressDocument) {
  //                             return Column(
  //                               children: [
  //                                 Container(
  //                                   alignment: Alignment.bottomLeft,
  //                                   margin: EdgeInsets.all(20),
  //                                   child: Text(
  //                                     AddressID,
  //                                     style: TextStyle(
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           },
  //                         ).toList(),
  //                       );
  //                     }
  //                   },
  //                 ),
  //               );
  // }
  //           }));



                /*ListView(
                  children: snapshot.data!.docs.map((AddressDocument) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.all(20),
                          child: Text(
                            AddressDocument["AddressID"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Container(
                        //     height: 100,
                        //     width: 400,
                        //     // margin: EdgeInsets.only(top: 50),
                        //     padding: EdgeInsets.all(20),
                        //     // color: HexColor('#BDBDBD').withOpacity(0.25),
                        //     decoration: BoxDecoration(
                        //         color: HexColor('#BDBDBD').withOpacity(0.25),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(20))),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(
                        //           "assets/images/woman.png",
                        //           height: 60,
                        //           width: 60,
                        //         ),
                        //         SizedBox(width: 30),
                        //         Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('พิชญาภรณ์ หัสเมตโต',
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.w500)),
                        //             Text('0995935451',
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.w500)),
                        //           ],
                        //         ),
                        //       ],
                        //     )),
                      ],
                    );
                  }).toList(),
                );*/