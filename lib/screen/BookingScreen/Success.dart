import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/main.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/ConfirmScreen/Payment.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';

class Success extends StatelessWidget {
  ReservationData reservationData;
  PaymentData paymentData;
  Housekeeper housekeeper;
  Success(
      {Key? key,
      required this.paymentData,
      required this.housekeeper,
      required this.reservationData})
      : super(key: key);
  final User? user = Auth().currentUser;

  Future SetReservation(String userid) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('User')
        .doc(userid)
        .collection('Reservation');
    DocumentReference newDocRef =
        users.doc(); // generates a new DocumentReference with a unique ID
    String newDocId = newDocRef.id; // gets the ID of the new document
    await newDocRef.set(reservationData.CreateReservationtoJson());

    // CollectionReference User = FirebaseFirestore.instance
    //     .collection('User')
    //     .doc(userid)
    //     .collection('Reservation');
    // DocumentReference newDocRef =
    //     User.doc(); // generates a new DocumentReference with a unique ID
    // String newDocId = newDocRef.id; // gets the ID of the new document
    // await newDocRef.set(reservationData.CreateReservationtoJson());

    // await FirebaseFirestore.instance
    //     .collection('User')
    //     .doc(uid)
    //     .collection('Reservation')
    //     .doc(newDocId)
    //     .collection('Address')
    //     .doc()
    //     .set(reservationData.CreateAddressReservationtoJson());

    await FirebaseFirestore.instance
        .collection('User')
        .doc(userid)
        .collection('Reservation')
        .doc(newDocId)
        .collection('Payment')
        .doc()
        .set(paymentData.CreatePaymenttoJson());
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 730,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 130,
                    color: HexColor("#5D5FEF"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'การจองสำเร็จ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    // alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 200),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: HexColor("#5D5FEF"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        minimumSize: Size(100, 40),
                      ),
                      child: Text(
                        'กลับ',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        SetReservation(_uid.toString());

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
