import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/AddPicturePlace.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/Addlocation.dart';

class MapsPage extends StatefulWidget {
  bool booking;
  final AddressData addressData;
  MapsPage({Key? key, required this.booking, required this.addressData})
      : super(key: key);
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;
  late LatLng _currentLocation;
  late LatLng _newLocation;
  // LatLng _initialCameraPosition = LatLng(37.4219999, -122.0840575);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // if (_currentLocation != null) {
    //   _moveCamera(_currentLocation);
    // }
  }

  Future<void> _getCurrentLocation() async {
    userLocation = await _getLocation();
    try {
      setState(() {
        _currentLocation = LatLng(
          userLocation.latitude,
          userLocation.longitude,
        );
        _newLocation = _currentLocation;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _moveCamera(LatLng location) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 15),
    ));
  }

  void _onMarkerDragEnd(LatLng location) {
    setState(() {
      _newLocation = location;
    });
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
                return Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation,
                        zoom: 15,
                      ),
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      onTap: (LatLng location) {
                        setState(() {
                          _newLocation = location;
                        });
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('new_location'),
                          position: _newLocation,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                        ),
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      // right: 16,
                      width: 100,
                      height: 50,
                      child: FloatingActionButton.extended(
                        backgroundColor: HexColor("#5D5FEF"),
                        onPressed: () {
                          print(
                              "${_newLocation.latitude} ${_newLocation.longitude}");
                          mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                  LatLng(_newLocation.latitude,
                                      _newLocation.longitude),
                                  18));
                          setState(() {
                            widget.addressData.point = GeoPoint(
                                _newLocation.latitude, _newLocation.longitude);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      // MyMapScreen()
                                      // MapsPage(addressData: widget.addressData)
                                      addpictureplace(
                                        booking: widget.booking == true
                                            ? true
                                            : false,
                                        addressData: widget.addressData,
                                      )));

                          // _getAddress(
                          //     _newLocation.latitude, _newLocation.longitude);
                          // print(Add);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Addplocation(
                          //             false, userLocation.latitude, userLocation.longitude))
                          //             );
                        },
                        label: Text(
                          "ตกลง",
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(Icons.near_me),
                      ),
                    ),
                  ],
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
            }));
  }
}
