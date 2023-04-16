// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:mutemaidservice/component/Placedetail.dart';
// import 'package:mutemaidservice/model/Data/PaymentData.dart';
// import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

// class CardJob extends StatefulWidget {
//   const CardJob({super.key});

//   @override
//   State<CardJob> createState() => _CardJobState();
// }

// class _CardJobState extends State<CardJob> {
//   late String BookingID;
//   late String UserID;
//   late int paymentPrice;
//   // Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
//   //   List<Map<String, dynamic>> data = [];

//   //   // Query the User collection for a document that contains the Reservation with the given ID
//   //   DocumentSnapshot<Map<String, dynamic>> userSnapshot =
//   //       await FirebaseFirestore.instance
//   //           .collection('User')
//   //           .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
//   //           .get();
//   //   Map<String, dynamic> UserData = userSnapshot.data()!;
//   //   data.add(UserData);

//   //   print('Number of User documents with Reservation : ${userSnapshot.data()}');

//   //   QuerySnapshot<Map<String, dynamic>> reservationSnapshot =
//   //       await userSnapshot.reference.collection('Reservation').get();

//   //   for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
//   //       in reservationSnapshot.docs) {
//   //     data.add(snapshot.data());
//   //   }

//   //   print(
//   //       'Number of Reservation documents with ID : ${reservationSnapshot.size}');

//   //   for (QueryDocumentSnapshot<Map<String, dynamic>> reservationDoc
//   //       in reservationSnapshot.docs) {
//   //     String reservationId = reservationDoc.id;
//   //     QuerySnapshot<Map<String, dynamic>> paymentSnapshot = await reservationDoc
//   //         .reference
//   //         .collection('Payment')
//   //         .where('PaymentStatus')
//   //         .get();

//   //     print(
//   //         'Number of Payment documents with PaymentStatus=true in Reservation document $reservationId: ${paymentSnapshot.size}');

//   //     for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
//   //         in paymentSnapshot.docs) {
//   //       Map<String, dynamic> docData = paymentDoc.data();
//   //       docData['ReservationId'] = reservationId;
//   //       data.add(docData);
//   //     }
//   //   }

//   //   return data;
//   // }

//   // List<Map<String, dynamic>> dataList = [];
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _getDataFromFirebase();
//   // }

//   // Future<void> _getDataFromFirebase() async {
//   //   dataList = await getDataFromFirebase();
//   //   setState(() {});
//   //   print(dataList);
//   //   // print(dataList);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//             //     TextButton(
//             //   child: Text('getdata'),
//             //   onPressed: () {
//             //     _getDataFromFirebase();
//             //   },
//             // )
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("User")
//                     .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
//                     .collection('Reservation')
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     return ListView(
//                       children: snapshot.data!.docs.map((BookingDocument) {
//                         FutureBuilder<String>(
//                           // future: BookingDocument.id,
//                           builder: (BuildContext context,
//                               AsyncSnapshot<String> snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               return Text(snapshot.data ?? 'No data');
//                             } else {
//                               return CircularProgressIndicator();
//                             }
//                           },
//                         );

//                         return InkWell(
//                           child: Container(
//                             height: 170,
//                             width: 400,
//                             margin: EdgeInsets.only(top: 30),
//                             padding: EdgeInsets.only(top: 10),
//                             decoration: BoxDecoration(
//                                 color: HexColor('#BDBDBD').withOpacity(0.25),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20))),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Icon(
//                                       Icons.calendar_month_rounded,
//                                       size: 40,
//                                       color: HexColor('#5D5FEF'),
//                                     ),
//                                     SizedBox(width: 30),
//                                     Text(BookingDocument["DatetimeService"],
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500)),
//                                     SizedBox(width: 42),
//                                     Container(
//                                       width: 90,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           color: HexColor('#1F8805'),
//                                           borderRadius: BorderRadius.only(
//                                               bottomLeft: Radius.circular(20),
//                                               topLeft: Radius.circular(20))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Icon(
//                                             Icons.explore,
//                                             size: 20,
//                                             color: HexColor('#FFFFFF'),
//                                           ),
//                                           Text('20 กม.',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white)),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 20),
//                                     Icon(
//                                       Icons.access_time,
//                                       size: 40,
//                                       color: HexColor('#5D5FEF'),
//                                     ),
//                                     SizedBox(width: 30),
//                                     Text(
//                                         "${BookingDocument["TimeStartService"]} น.",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500)),
//                                   ],
//                                 ),
//                                 Container(
//                                   width: 400,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                       color:
//                                           HexColor('#5D5FEF').withOpacity(0.9),
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(20),
//                                           bottomRight: Radius.circular(20))),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Image.asset(
//                                         "assets/images/money.png",
//                                         height: 40,
//                                         width: 40,
//                                       ),
//                                       SizedBox(width: 20),
//                                       Text(
//                                           "500 บาท", // ${BookingDocument.reference.collection("Payment").doc().path["PaymentStatus"]}
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white)),
//                                       SizedBox(width: 20)
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             setState(() {
//                               BookingID = BookingDocument.id;
//                             });
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         JobDetailScreen(BookingID, false)));
//                           },
//                         );
//                       }).toList(),
//                     );
//                   }
//                 }));
//   }
// }
