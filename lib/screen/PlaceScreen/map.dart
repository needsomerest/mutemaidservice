import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:mutemaidservice/screen/PlaceScreen/Addlocation.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;

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
    // LocationData? currentLocation;
    // String address = getPlace() as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาตำแหน่งที่ตั้งสถานที่'),
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
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 15),
            );

            /*
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );*/
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // mapController.animateCamera(CameraUpdate.newLatLngZoom(
          //     LatLng(userLocation.latitude, userLocation.longitude), 18));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Addplocation(
                      false, userLocation.latitude, userLocation.longitude)));
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

Future<String> _getAddress(double? lat, double? lang) async {
  if (lat == null || lang == null) return "";
  GeoCode geoCode = GeoCode();
  Address address =
      await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
  // return "${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}"
  return "${address.streetAddress},${address.city}, ${address.region},  ${address.countryName}";
}
