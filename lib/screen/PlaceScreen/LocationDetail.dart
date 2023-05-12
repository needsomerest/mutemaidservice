import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:mutemaidservice/screen/PlaceScreen/AddPlaceScreen.dart';
import 'package:mutemaidservice/screen/PlaceScreen/Addlocation.dart';

class GetUserLocation extends StatefulWidget {
  double latitude;
  double longitude;
  GetUserLocation(this.latitude, this.longitude);
  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  LocationData? currentLocation;
  String address = "";

  @override
  Widget build(BuildContext context) {
    _getAddress(widget.latitude, widget.longitude).then((value) {
      setState(() {
        // currentLocation = location;
        address = value;
      });
    });
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Addplocation(false, address),
              Text("Address: $address"),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    // return "${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}"
    return "${address.streetAddress},${address.city}, ${address.region},  ${address.countryName}";
  }
}
