import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/Placedetail.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

class CardJobTest extends StatefulWidget {
  const CardJobTest({super.key});

  @override
  State<CardJobTest> createState() => _CardJobTestState();
}

class _CardJobTestState extends State<CardJobTest> {
  late String BookingID;
  late String UserID;
  late int paymentPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
                .collection('Reservation')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.docs.length == 0) {
                  return Text('No Record Found');
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id = snapshot.data!.docs[index].id;
                        return GestureDetector(
                          onTap: () {},
                          child: Text('$id'),
                        );
                      });
                }

                // children: snapshot.data!.docs.map((BookingDocument) {

                // BookingDocument.reference
                //     .collection('Payment')
                //     .doc()
                //     .get()
                //     .then((paymentDoc) {
                //   String paymentStatus = paymentDoc.get('PaymentStatus');
                //   print(paymentStatus);
                // });

                // final paymentDoc = await BookingDocument.reference
                //     .collection('Payment')
                //     .doc()
                //     .get();
                // final paymentPrice = paymentDoc['PaymentPrice'];

                // return InkWell(
                //   child: Container(
                //     height: 170,
                //     width: 400,
                //     margin: EdgeInsets.only(top: 30),
                //     padding: EdgeInsets.only(top: 10),
                //     decoration: BoxDecoration(
                //         color: HexColor('#BDBDBD').withOpacity(0.25),
                //         borderRadius:
                //             BorderRadius.all(Radius.circular(20))),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Icon(
                //               Icons.calendar_month_rounded,
                //               size: 40,
                //               color: HexColor('#5D5FEF'),
                //             ),
                //             SizedBox(width: 30),
                //             Text(BookingDocument["DatetimeService"],
                //                 style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w500)),
                //             SizedBox(width: 90),
                //             Container(
                //               width: 90,
                //               height: 35,
                //               decoration: BoxDecoration(
                //                   color: HexColor('#1F8805'),
                //                   borderRadius: BorderRadius.only(
                //                       bottomLeft: Radius.circular(20),
                //                       topLeft: Radius.circular(20))),
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Icon(
                //                     Icons.explore,
                //                     size: 20,
                //                     color: HexColor('#FFFFFF'),
                //                   ),
                //                   Text('20 กม.',
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.w500,
                //                           color: Colors.white)),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             SizedBox(width: 20),
                //             Icon(
                //               Icons.access_time,
                //               size: 40,
                //               color: HexColor('#5D5FEF'),
                //             ),
                //             SizedBox(width: 30),
                //             Text(
                //                 "${BookingDocument["TimeStartService"]} น.",
                //                 style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w500)),
                //           ],
                //         ),
                //         Container(
                //           width: 400,
                //           height: 50,
                //           decoration: BoxDecoration(
                //               color: HexColor('#5D5FEF').withOpacity(0.9),
                //               borderRadius: BorderRadius.only(
                //                   bottomLeft: Radius.circular(20),
                //                   bottomRight: Radius.circular(20))),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Image.asset(
                //                 "assets/images/money.png",
                //                 height: 40,
                //                 width: 40,
                //               ),
                //               SizedBox(width: 20),
                //               Text(
                //                   " บาท", //${paymentStatus} ${BookingDocument.reference.collection("Payment").doc().path["PaymentStatus"]}
                //                   style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white)),
                //               SizedBox(width: 20)
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                //   onTap: () {
                //     setState(() {
                //       BookingID = BookingDocument.id;
                //     });
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 JobDetailScreen(BookingID, false)));
                //   },
                // );
                //   }).toList(),
                // );
              }
            }));
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

// class CardJobTest extends StatefulWidget {
//   const CardJobTest({Key? key});

//   @override
//   State<CardJobTest> createState() => _CardJobTestState();
// }

// class _CardJobTestState extends State<CardJobTest> {
//   late String BookingID;
//   late String UserID;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("User")
//               .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
//               .collection('Reservation')
//               .snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               // final bookingDocs = snapshot.data!.docs;
//               return FutureBuilder<List<Widget>>(
//                 future: Future.wait(
//                   snapshot.data!.docs.map((BookingDocument) {
//                     return BookingDocument.reference
//                         .collection('Payment')
//                         .doc()
//                         .get()
//                         .then((paymentDoc) {
//                       final paymentPrice = paymentDoc['PaymentPrice'];

//                       return InkWell(
//                         child: Container(
//                           height: 170,
//                           width: 400,
//                           margin: EdgeInsets.only(top: 30),
//                           padding: EdgeInsets.only(top: 10),
//                           decoration: BoxDecoration(
//                               color: HexColor('#BDBDBD').withOpacity(0.25),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_month_rounded,
//                                     size: 40,
//                                     color: HexColor('#5D5FEF'),
//                                   ),
//                                   SizedBox(width: 30),
//                                   Text(BookingDocument["DatetimeService"],
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500)),
//                                   SizedBox(width: 90),
//                                   Container(
//                                     width: 90,
//                                     height: 35,
//                                     decoration: BoxDecoration(
//                                         color: HexColor('#1F8805'),
//                                         borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(20),
//                                             topLeft: Radius.circular(20))),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Icon(
//                                           Icons.explore,
//                                           size: 20,
//                                           color: HexColor('#FFFFFF'),
//                                         ),
//                                         Text('20 กม.',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white)),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   SizedBox(width: 20),
//                                   Icon(
//                                     Icons.access_time,
//                                     size: 40,
//                                     color: HexColor('#5D5FEF'),
//                                   ),
//                                   SizedBox(width: 30),
//                                   Text(
//                                       "${BookingDocument["TimeStartService"]} น.",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500)),
//                                 ],
//                               ),
//                               Container(
//                                 width: 400,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     color: HexColor('#5D5FEF').withOpacity(0.9),
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(20),
//                                         bottomRight: Radius.circular(20))),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Image.asset(
//                                       "assets/images/money.png",
//                                       height: 40,
//                                       width: 40,
//                                     ),
//                                     SizedBox(width: 20),
//                                     Text("X บาท", //${paymentPrice}
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white)),
//                                     SizedBox(width: 20)
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         onTap: () {
//                           setState(() {
//                             BookingID = BookingDocument.id;
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     JobDetailScreen(BookingID, false)),
//                           );
//                         },
//                       );
//                     });
//                   }),
//                 ),
//                 builder: (context, AsyncSnapshot<List<Widget>> widgetSnapshot) {
//                   if (widgetSnapshot.connectionState ==
//                       ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (widgetSnapshot.hasData) {
//                     return ListView(children: widgetSnapshot.data!);
//                   } else {
//                     return Text('Error: ${widgetSnapshot.error}');
//                   }
//                 },
//               );
//             }
//           }),
//     );
//   }
// }
