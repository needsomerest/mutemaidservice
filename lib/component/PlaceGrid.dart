import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'PlaceAtom.dart';

class PlaceGrid extends StatefulWidget {
  final ReservationData reservationData;
  final AddressData addressData;
  final Housekeeper housekeeper;
  PlaceGrid(
      {Key? key,
      required this.reservationData,
      required this.addressData,
      required this.housekeeper})
      : super(key: key);
  @override
  State<PlaceGrid> createState() => _PlaceGridState();
}

class _PlaceGridState extends State<PlaceGrid> {
  final User? user = Auth().currentUser;

  int selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(_uid)
                .collection("Address")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Object?> address =
                    snapshot.data!.docs.map((AddressDocument) {
                  return AddressDocument.data();
                }).toList();
                return GridView.builder(
                    shrinkWrap: false,
                    padding: const EdgeInsets.all(20),
                    scrollDirection: Axis.vertical,
                    // itemCount: snapshot.data!.docs.length,
                    itemCount: address.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Map<dynamic, dynamic> useraddress = address[index] as Map;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCard = index;
                          });
                          if (selectedCard == index) {
                            widget.reservationData.AddressID =
                                useraddress["AddressID"];
                            widget.reservationData.addressName =
                                useraddress["AddressName"];
                            widget.reservationData.addresstype =
                                useraddress["Type"];
                            widget.reservationData.addressDetail =
                                useraddress["AddressDetail"] +
                                    " " +
                                    useraddress["Provice"] +
                                    useraddress["Region"];
                            widget.reservationData.addressImage =
                                useraddress["AddressImage"];
                            widget.reservationData.sizeroom =
                                useraddress["Sizeroom"];
                            widget.reservationData.AddressNote =
                                useraddress["Note"];
                            widget.reservationData.AddressPoint =
                                useraddress["Point"];
                            widget.addressData.AddressID =
                                useraddress["AddressID"];
                            widget.addressData.Type = useraddress["Type"];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingScreen(
                                          reservationData:
                                              widget.reservationData,
                                          addressData: widget.addressData,
                                          housekeeper: widget.housekeeper,
                                          backward: false,
                                          /*addressID: useraddress["AddressID"],
                                    addressName: useraddress["AddressName"],
                                    addresstype: useraddress["Type"]),*/
                                        )));
                          }
                        },
                        child: PlaceAtom(
                          useraddress["AddressName"],
                          useraddress["AddressImage"],
                          selectedCard == index ? true : false,
                          useraddress["AddressID"],
                        ),
                      );
                    });
              }
            }));
  }
}
