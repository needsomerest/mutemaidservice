import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haversine_distance/haversine_distance.dart';

import 'dart:math' show cos, sqrt, asin;
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalculateDistance extends StatefulWidget {
  String HousekeeperID;
  CalculateDistance(this.HousekeeperID);
  // const CalculateDistance({super.key});
  // CalculateDistance(this.lat1, this.lat2, this.lon1, this.lon2);
  @override
  State<CalculateDistance> createState() => _CalculateDistanceState();
}

class _CalculateDistanceState extends State<CalculateDistance> {
  // late GeoPoint Location1;
  late final Location startCoordinate;
  final endCoordinate = new Location(60.393032, 5.327248);

  final haversineDistance = HaversineDistance();
  late GeoPoint Location2;
  late int MaxDistance;

  // Future getLocationMaid() async {
  //   final docHousekeeper = await FirebaseFirestore.instance
  //       .collection('Housekeeper')
  //       .doc(widget.HousekeeperID)
  //       .get();

  //   setState(() {
  //     MaxDistance = docHousekeeper['MaxDistance'];
  //     // Location1 = docHousekeeper['CurrentLocation'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Housekeeper")
                .where('HousekeeperID', isEqualTo: widget.HousekeeperID)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((MaidDocument) {
                    // Location1 = MaidDocument["CurrentLocation"];

                    // Location2 = MaidDocument["Address"]; Ref
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: test2, child: Text("OK")),
                      ],
                    );

                    //${Location1.latitude}
                  }).toList(),
                );
              }
            }));
  }

  void test2() {
    final distanceInMeter =
        haversineDistance.haversine(startCoordinate, endCoordinate, Unit.METER);

    print(
        'Distance between start and end coordinate is: ${distanceInMeter} m.');
    // print(
    //     'la: ${startCoordinate.latitude} long: ${startCoordinate.longitude} ');

    final distanceInKm =
        haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM);

    print('Distance between start and end coordinate is: ${distanceInKm} km.');
  }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }
}
