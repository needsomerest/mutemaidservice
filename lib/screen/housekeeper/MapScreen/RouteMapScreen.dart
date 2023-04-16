import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteMapPage extends StatefulWidget {
  LatLng endLocation;
  RouteMapPage(this.endLocation);
  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  // LatLng startLocation = LatLng(13.682467242656932, 100.47146210807037);
  // LatLng endLocation = LatLng(widget.tagetLocation.latitude, widget.tagetLocation.longitude);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarkers() {
    // markers.add(
    //   Marker(
    //     markerId: MarkerId('startLocation'),
    //     position: startLocation,
    //     infoWindow: InfoWindow(title: 'Start Location'),
    //   ),
    // );
    markers.add(
      Marker(
        markerId: MarkerId('endLocation'),
        position: widget.endLocation,
        infoWindow: InfoWindow(title: 'ที่อยู่ลูกค้า'),
      ),
    );
  }

  // void _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyDRCWJG-f5eQwGmPNXZJkW0GlJ7CttreNY',
  //     PointLatLng(startLocation.latitude, startLocation.longitude),
  //     // PointLatLng(endLocation.latitude, endLocation.longitude),
  //     PointLatLng(endLocation.latitude, endLocation.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //     setState(() {
  //       PolylineId id = PolylineId('poly');
  //       Polyline polyline = Polyline(
  //         polylineId: id,
  //         color: Colors.red,
  //         points: polylineCoordinates,
  //         width: 3,
  //       );
  //       polylines[id] = polyline;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _addMarkers();
    // _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: widget.endLocation,
          zoom: 5,
        ),
        markers: markers,
        // polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }
}
