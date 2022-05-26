import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import '../../server/api.dart';

class offerMap extends StatefulWidget {
  int id;
  offerMap(this.id);

  @override
  State<offerMap> createState() => _offerMapState();
}

class _offerMapState extends State<offerMap> {
  double? lat = null;
  double? long = null;
  late BitmapDescriptor mapMarker;
  List<Marker> allMarkers = [];
  var _offerData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    setCustomMarker();
  }

  getloc(BuildContext context) async {
    setState(() {
      lat = double.parse(_offerData['Lat']);
      long = double.parse(
        _offerData['Long'],
      );
    });
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/pin2.png');
  }

  @override
  Widget build(BuildContext context) {
    while (lat == null) {
      return Container(
        height: 200,
        width: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          child: GoogleMap(
            markers: Set.from(allMarkers),
            initialCameraPosition:
                CameraPosition(target: LatLng(lat!, long!), zoom: 15),
            zoomGesturesEnabled: true,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF605F5F).withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: 300,
        ),
      ),
    );
  }

  _loadData() async {
    var response = await Api().getData('/API/products/${widget.id}/','JWT');
    if (response.statusCode == 200) {
      setState(
        () {

          _offerData = json.decode(response.body);
          // print(_offerData);
          lat = double.parse(_offerData['Lat']);
          long = double.parse(
            _offerData['Long'],
          );
          allMarkers.add(
            Marker(
              markerId: MarkerId(_offerData['id'].toString()),
              draggable: false,
              position: LatLng(
                double.parse(_offerData['Lat']),
                double.parse(
                  _offerData['Long'],
                ),
              ),
              icon: mapMarker,
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
