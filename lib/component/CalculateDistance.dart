import 'package:haversine_distance/haversine_distance.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalculateDistance extends StatefulWidget {
  String HousekeeperID;
  CalculateDistance(this.HousekeeperID);

  @override
  State<CalculateDistance> createState() => _CalculateDistanceState();
}

class _CalculateDistanceState extends State<CalculateDistance> {
  late final Location startCoordinate;
  final endCoordinate = new Location(60.393032, 5.327248);

  final haversineDistance = HaversineDistance();
  late GeoPoint Location2;
  late int MaxDistance;

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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: test2, child: Text("OK")),
                      ],
                    );
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

    final distanceInKm =
        haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM);

    print('Distance between start and end coordinate is: ${distanceInKm} km.');
  }
}
