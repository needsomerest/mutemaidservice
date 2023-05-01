import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';

class JobScreen extends StatefulWidget {
  final Maid maid;
  JobScreen({Key? key, required this.maid}) //required this.addressData
      : super(key: key);
  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  // final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  late GeoPoint location1;
  late GeoPoint location2;
  late String ReservationId;
  late String UserId;
  Future<void> updateReserve({
    required double distance,
  }) async {
    try {
      final docMaid = await FirebaseFirestore.instance
          .collection('User')
          .doc(UserId)
          .collection('Reservation')
          .doc(ReservationId)
          .update({
        'Distance': distance,
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];
    // final String userID = "EjrH3vIPBAdtuMBBTpTXmzb0Pil2";

    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    print('Number of User documents: ${UserSnapshot.size}');

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      DocumentSnapshot<Map<String, dynamic>> maidSnapshot =
          await FirebaseFirestore.instance
              .collection("Housekeeper")
              .doc(widget.maid.HousekeeperID)
              .get();

      print('Number of Review documents: ${maidSnapshot.data()}');

      QuerySnapshot<Map<String, dynamic>> reserveSnapshot =
          await FirebaseFirestore.instance
              .collection("User")
              .doc(UserDoc.id)
              .collection('Reservation')
              .where('HousekeeperID', isEqualTo: widget.maid.HousekeeperID)
              .where('HousekeeperRequest', isEqualTo: "กำลังตรวจสอบ")
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> reserveDoc
          in reserveSnapshot.docs) {
        String addressID = reserveDoc.data()['AddressID'];
        DocumentSnapshot<Map<String, dynamic>> addressSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .collection('Address')
                .doc(addressID)
                .get();

        print(
            'Number of User documents with id=$addressID : ${addressSnapshot.data()}');

        QuerySnapshot<Map<String, dynamic>> paymentSnapshot =
            await reserveDoc.reference.collection('Payment').get();

        print(
            'Number of User documents with Payment : ${paymentSnapshot.size}');

        Map<String, dynamic> reserveData = reserveDoc.data();
        Map<String, dynamic>? addressData = addressSnapshot.data();
        Map<String, dynamic>? maidData = maidSnapshot.data();
        Map<String, dynamic> mergedData = {};
        reserveData['ReservationId'] = reserveDoc.id;
        reserveData['UserId'] = UserDoc.id;
        print(
            'Number of Reserve documents with id=${reserveData['ReservationId']}');
        for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
            in paymentSnapshot.docs) {
          Map<String, dynamic> paymentData = paymentDoc.data();
          if (paymentData != null) {
            mergedData.addAll(paymentData);
          }
          //  mergedData.addAll(paymentData);
        }
        mergedData.addAll(reserveData);
        if (addressData != null) {
          mergedData.addAll(addressData);
        }
        if (maidData != null) {
          mergedData.addAll(maidData);
        }
        data.add(mergedData);
      }
    }
    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {});
    print(dataList);
  }

  late GeoPoint currentLocation;

  @override
  Widget build(BuildContext context) {
    return
        //TextButton(onPressed: _getDataFromFirebase, child: Text('Get'));
        /*   ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> data = dataList[index];
        location1 = data['CurrentLocation'];
        location2 = data['Point'];
        double distance = Geolocator.distanceBetween(location1.latitude,
            location1.longitude, location2.latitude, location2.longitude);
        return Text(
          '${data['ReservationId']}',
          style: TextStyle(fontSize: 16),
        );
      },
    );*/
        Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 30,
        ),
        title: Text('งานทั้งหมด',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight
                    .bold)), //"${currentLocation.latitude} ${currentLocation.longitude}"
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: dataList.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ไม่พบงานที่รับได้ในขณะนี้",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      // alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: HexColor("#5D5FEF"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          // minimumSize: Size(100, 40),
                        ),
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeMaidScreen(
                                        maid: widget.maid,
                                      )));
                        },
                      ),
                    )
                  ],
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/job-search.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(width: 50),
                        Image.asset(
                          "assets/images/filter.png",
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    Container(
                        color: Colors.white,
                        height: 550,
                        width: 700,
                        child: ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data = dataList[index];
                            location1 = data['CurrentLocation'];
                            location2 = data['Point'];
                            double distance = Geolocator.distanceBetween(
                                location1.latitude,
                                location1.longitude,
                                location2.latitude,
                                location2.longitude);
                            return (((distance / 1000) <=
                                    data[
                                        'MaxDistance'])) //&&(data['HousekeeperRequest'] == "กำลังตรวจสอบ")
                                ? InkWell(
                                    child: Container(
                                      height: 170,
                                      width: 400,
                                      margin: EdgeInsets.only(top: 30),
                                      padding: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: HexColor('#BDBDBD')
                                              .withOpacity(0.25),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.calendar_month_rounded,
                                                size: 40,
                                                color: HexColor('#5D5FEF'),
                                              ),
                                              SizedBox(width: 30),
                                              Text(data["DatetimeService"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(width: 42),
                                              Container(
                                                width: 90,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    color: HexColor('#1F8805'),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(
                                                      Icons.explore,
                                                      size: 20,
                                                      color:
                                                          HexColor('#FFFFFF'),
                                                    ),
                                                    Text(
                                                        '${(distance / 1000).toString().substring(0, 4)} กม.',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Icon(
                                                Icons.access_time,
                                                size: 40,
                                                color: HexColor('#5D5FEF'),
                                              ),
                                              SizedBox(width: 30),
                                              Text(
                                                  "${data["TimeStartService"]} น.",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Container(
                                            width: 400,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: HexColor('#5D5FEF')
                                                    .withOpacity(0.9),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Image.asset(
                                                  "assets/images/money.png",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                    "${data['PaymentPrice']} บาท", // ${BookingDocument.reference.collection("Payment").doc().path["PaymentStatus"]}
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                                SizedBox(width: 20)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        ReservationId = data['ReservationId'];
                                        UserId = data['UserId'];
                                      });
                                      updateReserve(
                                        distance: distance,
                                      ).then((value) {
                                        print('Maid updated successfully!');
                                      }).catchError((error) {
                                        print('Error updating Maid: $error');
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JobDetailScreen(
                                                      widget.maid,
                                                      data['ReservationId'],
                                                      false,
                                                      "")));
                                    },
                                  )
                                : SizedBox(
                                    height: 1,
                                  );
                            // Text(
                            //   'distance: ${distance / 1000}',
                            //   style: TextStyle(fontSize: 16),
                            // );
                          },
                        )
                        // child: CardJob(),
                        )
                  ],
                ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}
