import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/CardPromotion.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/PlaceScreen/MyplaceScreen.dart';
import 'PlaceAtom.dart';

class PlaceGrid extends StatefulWidget {
  // const PlaceGrid({super.key});
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
                // Map<dynamic, dynamic> useraddress = address[index] as Map;
                // var fbEntries = List<Entry>.from(snapshot.data.docs.map((json) => Entry.fromJson(json)));
                return GridView.builder(
                    shrinkWrap: false,
                    padding: const EdgeInsets.all(20),
                    scrollDirection: Axis.vertical,
                    // itemCount: snapshot.data!.docs.length,
                    itemCount: address.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: MediaQuery.of(context).size.width /
                      //     (MediaQuery.of(context).size.height / 3),
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
                                          /*addressID: useraddress["AddressID"],
                                    addressName: useraddress["AddressName"],
                                    addresstype: useraddress["Type"]),*/
                                        )));
                          }
                        },
                        child: PlaceAtom(
                            useraddress["AddressName"],
                            useraddress["AddressImage"],
                            selectedCard == index ? true : false),

                        //  Card(
                        //   // check if the index is equal to the selected Card integer
                        //   color: selectedCard == index
                        //       ? Colors.blue
                        //       : Colors.amber,
                        //   child: Container(
                        //     height: 200,
                        //     width: 200,
                        //     child: Center(
                        //       child: Text(
                        //         useraddress["Address"],
                        //         // snapshot.data!.docs.forEach((AddressDocument) { }),
                        //         // List<Widget>.from(snapshot.data.docs.map((e)=> Text('${e['title']}'))),
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      );
                    });
              }
            }));
  }
}


// class PlaceGrid extends StatelessWidget {
//   int selectedCard = -1;
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection("Address").snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return GridView.builder(
//         shrinkWrap: false,
//         scrollDirection: Axis.vertical,
//         itemCount: 10,
//         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: MediaQuery.of(context).size.width /
//               (MediaQuery.of(context).size.height / 3),
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               setstate(() {
//                 // ontap of each card, set the defined int to the grid view index
//                 selectedCard = index;
//               });
//             },
//             child: Card(
//               // check if the index is equal to the selected Card integer
//               color: selectedCard == index ? Colors.blue : Colors.amber,
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 child: Center(
//                   child: Text(
//                     '$index',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//             }
//           }));
// }

// return GridView.count(
//                 primary: false,
//                 padding: const EdgeInsets.all(20),
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//                 crossAxisCount: 2,
//                 children: snapshot.data!.docs.map((AddressDocument) {
//                   return PlaceAtom(
//                     AddressDocument["Address"],
//                     AddressDocument["Addressimage"],
//                   );
//                 }).toList(),
//               );

// ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: snapshot.data!.docs.map((AddressDocument) {
//                   return Container(
//                     height: 200,
//                     width: 200,
//                     margin: EdgeInsets.all(10),
//                     child: Center(
//                       child: Flexible(
//                         child: CardPromotion(
//                           AdsDocument["AdsHeader"],
//                           AdsDocument["AdsDetails"],
//                           AdsDocument["AdsPicture"],
//                           100,
//                           12,
//                           5,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
