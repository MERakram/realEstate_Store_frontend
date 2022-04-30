import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {


  runApp(
    MaterialApp( home : mapSearch(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class mapSearch extends StatefulWidget {

  @override
  _mapSearchState createState() {
    return _mapSearchState();
  }
}

class _mapSearchState extends State<mapSearch> {
   Position? position=null;
    double? lat=null;
    double? long=null;
   getloc(BuildContext context) async {
     try{
       LocationPermission permission = await Geolocator.requestPermission();
       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
       print('long = ${position.longitude}');
       print('lat = ${position.latitude}');
       setState(() {
         lat =position.latitude;
         long=position.longitude;
       });
     }
     catch(e) {
       throw e;
     }}
  // final Marker _offermarker = Marker(
  //   markerId: MarkerId('_offermarker'),
  //   infoWindow: InfoWindow(title: 'offer'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(position.latitude, long));
   void initState() {
     super.initState();
     WidgetsBinding.instance?.addPostFrameCallback((_) => getloc(context));
   }
  @override
  Widget build(BuildContext context) {
     while (lat == null){
       return CircularProgressIndicator();
     }
     return GoogleMap(
       // markers: {_offermarker},
       initialCameraPosition:
       CameraPosition(target: LatLng(lat!, long!), zoom: 15),
       zoomGesturesEnabled: true,
     );
       }
  }
