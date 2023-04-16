import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoAddress extends StatelessWidget {
  final ReservationData reservationData;
  InfoAddress({Key? key, required this.reservationData}) : super(key: key);
  final User? user = Auth().currentUser;

  Future<String> getPhoneNumber(String uid) async {
    var phone_number;
    final docRef = FirebaseFirestore.instance.collection('User').doc(uid);
    await docRef.get().then((doc) {
      if (doc.exists) {
        final myValue = doc.get('PhoneNumber');
        phone_number = myValue.toString();
        return ('Value of myField: $myValue');
      } else {
        return ('Document does not exist');
      }
    }).catchError((error) => print('Error getting document: $error'));
    return phone_number;
  }

  Future<String> getRegion(String uid) async {
    var REGION_USER;
    final docRef = FirebaseFirestore.instance.collection('User').doc(uid);
    await docRef.get().then((doc) {
      if (doc.exists) {
        final myValue = doc.get('Region');
        REGION_USER = myValue.toString();
        return ('Value of myField: $myValue');
      } else {
        return ('Document does not exist');
      }
    }).catchError((error) => print('Error getting document: $error'));
    return REGION_USER;
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;

    return Container(
      height: 500,
      width: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HexColor('#5D5FEF').withOpacity(0.2),
        border: Border.all(width: 1.5, color: HexColor('#5D5FEF')),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.displayName ?? 'UserName',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#000000')),
          ),
          FutureBuilder<String>(
            future: getPhoneNumber(_uid.toString()),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                reservationData.PhoneNumber = snapshot.data.toString();
                return Text(snapshot.data ?? 'No data');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<String>(
            future: getRegion(_uid.toString()),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                reservationData.PhoneNumber = snapshot.data.toString();
                return Text(snapshot.data ?? 'No data');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'รายละเอียดที่อยู่',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          Flexible(
            child: Text(
              reservationData.addresstype +
                  '\n' +
                  reservationData.addressDetail,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                // size: , // Image radius
                child: Image.network(
                  reservationData.addressImage,
                  fit: BoxFit.cover,
                  height: 190,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
