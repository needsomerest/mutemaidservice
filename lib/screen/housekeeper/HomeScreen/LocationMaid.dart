import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobScreen.dart';

class LocationMaid extends StatefulWidget {
  final Maid maid;
  LocationMaid({Key? key, required this.maid}) //required this.addressData
      : super(key: key);
  @override
  _LocationMaidState createState() => _LocationMaidState();
}

class _LocationMaidState extends State<LocationMaid> {
  // final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  late Position userLocation;
  late GoogleMapController mapController;
  Future setLocation({
    required GeoPoint value,
  }) async {
    final docHousekeeper = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(widget.maid.HousekeeperID);

    final json = {
      'CurrentLocation': value,
    };
    await docHousekeeper.update(json);

    //createUserWithEmailAndPassword(firstname, lastname, profileimage,phonenumber);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          late GeoPoint currentlocation;
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation.latitude, userLocation.longitude), 18));
          setState(() {
            currentlocation =
                GeoPoint(userLocation.latitude, userLocation.longitude);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      // CalculateDistance(widget.HousekeeperID)
                      JobScreen(
                        maid: widget.maid,
                      )
                  // JobDetailScreen(
                  //     "AlK1obLuMav3f3zOIFIA", false)
                  ));
          // MaterialPageRoute(builder: (context) => JobScreen()));
          setLocation(value: currentlocation);
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       content: Text(
          //           'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} '),
          //     );
          //   },
          // );
        },
        label: Text("ตกลง"),
        icon: Icon(Icons.near_me),
      ),
    );
  }
}


// Future<String> _getAddress(double? lat, double? lang) async {
//   if (lat == null || lang == null) return "";
//   GeoCode geoCode = GeoCode();
//   Address address =
//       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
//   // return "${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}"
//   return "${address.streetAddress},${address.city}, ${address.region},  ${address.countryName}";
// }

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:mutemaidservice/component/CalculateDistance.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobScreen.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/Addlocation.dart';

class LocationMaid extends StatefulWidget {
  String HousekeeperID;
  LocationMaid(this.HousekeeperID);
  @override
  _LocationMaidState createState() => _LocationMaidState();
}

class _LocationMaidState extends State<LocationMaid> {
  late GeoPoint currentlocation;
  late Position userLocation;
  late GoogleMapController mapController;
  // late int MaxDistance;

  Future setLocation({
    required GeoPoint value,
  }) async {
    final docHousekeeper = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(widget.HousekeeperID);

    final json = {
      'CurrentLocation': value,
    };
    await docHousekeeper.update(json);

    //createUserWithEmailAndPassword(firstname, lastname, profileimage,phonenumber);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  final fs = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // LocationData? currentLocation;
    // String address = getPlace() as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            currentlocation =
                GeoPoint(userLocation.latitude, userLocation.longitude);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      // CalculateDistance(widget.HousekeeperID)
                      JobScreen(widget.HousekeeperID)
                  // JobDetailScreen(
                  //     "AlK1obLuMav3f3zOIFIA", false)
                  ));
          // MaterialPageRoute(builder: (context) => JobScreen()));
          setLocation(value: currentlocation);
        },
        label: Text(
          "ตกลง",
          textAlign: TextAlign.center,
        ),
        // icon: Icon(Icons.near_me),
      ),
    );
  }
}
*/