// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geocode/geocode.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';

// import 'package:mutemaidservice/component/CardPromotion.dart';
// import 'package:mutemaidservice/component/MaidDetail.dart';
// import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
// import 'package:mutemaidservice/model/Data/PaymentData.dart';
// import 'package:mutemaidservice/model/Data/ReservationData.dart';
// import 'package:mutemaidservice/screen/user/ConfirmScreen/Payment.dart';

// class testesus extends StatelessWidget {
//   // String UserID;{required this.UserID,
//   String TabStatus;
//   testesus({required this.TabStatus});

//   final newHousekeeper = Housekeeper("HousekeeperID", "FirstName", "LastName",
//       "ProfileImage", 0, 0, 0, 0, 0, "CommunicationSkill", true, true);
//   final newPayment = Payment(
//     "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/PaymentImage%2F8fc39ba2-f15a-44f4-b5bc-292a06ab6c4b3751896307870846248.jpg%2FPaymentImage?alt=media&token=d6436475-f482-44bf-9700-7768413cdf0a",
//         0,
//       "กำลังตรวจสอบ");
//   Future<String> getPayment(String reserveid, String addressid) async {
//     final docRef = FirebaseFirestore.instance
//         .collection('User')
//         .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
//         .collection('Reservation')
//         .doc(reserveid)
//         .collection('Payment')
//         .doc();
//     await docRef.get().then((doc) {
//       if (doc.exists) {
//         newPayment.PaymentPrice = doc.get('PaymentPrice');
//       } else {
//         return ('Document does not exist');
//       }
//     }).catchError((error) => print('Error getting document: $error'));
//     return ('Sucess');
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("User")
//               .doc()
//               .collection("Reservation")
//               .where('Status', isEqualTo: TabStatus)
//               .snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               if (snapshot.data!.docs.isEmpty) {
//                 return Center(
//                     child: Column(
//                   children: [
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Text('ยังไม่มีรายการ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 25,
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: HexColor("#5D5FEF"),
//                         padding: EdgeInsets.all(15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         minimumSize: Size(130, 40),
//                       ),
//                       child: Text(
//                         'จองตอนนี้',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BookingScreen(
//                                       reservationData: newReservationData,
//                                       addressData: newAddress,
//                                       housekeeper: newHousekeeper,
//                                     )));
//                       },
//                     )
//                   ],
//                 ));
//               } else {
//                 return ListView(
//                   // scrollDirection: Axis.horizontal,
//                   children: snapshot.data!.docs.map((ReservationDocument) {
//                     newReservationData.DateTimeService =
//                         ReservationDocument['DatetimeService'];
//                     newReservationData.Note = ReservationDocument['Note'];
//                     newReservationData.Package = ReservationDocument['Package'];
//                     newReservationData.Status = ReservationDocument['Status'];
//                     String TimeDuration = ReservationDocument['TimeDuration'];
//                     newReservationData.TimeEndService =
//                         ReservationDocument['TimeEndService'];
//                     newReservationData.Timeservice =
//                         ReservationDocument['TimeService'];
//                     newReservationData.TimeStartService =
//                         ReservationDocument['TimeStartService'];
//                     newReservationData.AddressID =
//                         ReservationDocument['AddressID'];
//                     newReservationData.HousekeeperID =
//                         ReservationDocument['HousekeeperID'];
//                     FutureBuilder<String>(
//                       future: getPhoneNumber(
//                           UserID, ReservationDocument['AddressID']),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<String> snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return Text(snapshot.data ?? 'No data');
//                         } else {
//                           return CircularProgressIndicator();
//                         }
//                       },
//                     );
//                     return Center(
//                       child: Flexible(
//                           child: Column(children: [
//                         MybookingDetail(
//                           BookingID: ReservationDocument.id,
//                           Duration: TimeDuration,
//                           reservationData: newReservationData,
//                           addressData: newAddress,
//                         )
//                       ])),
//                     );
//                   }).toList(),
//                 );
//               }
//             }
//           }));
// }
