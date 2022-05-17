import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import '../../server/api.dart';

class offerMap extends StatefulWidget {
  int id;
  offerMap(this.id);
  // final Marker _offermarker = Marker(
  //   markerId: MarkerId('_offermarker'),
  //   infoWindow: InfoWindow(title: 'offer'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(Lat, Long));

  @override
  State<offerMap> createState() => _offerMapState();
}

class _offerMapState extends State<offerMap> {
  List<Marker> allMarkers = [];
  var _offerData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    for (int i=0; i < _offerData.length; i++) {
      allMarkers.add(
        Marker(
          markerId: MarkerId(_offerData['id']),
          draggable: false,
          infoWindow: InfoWindow(
            title: _offerData['title'],
            snippet: _offerData['Location'],
          ),
          position: LatLng(_offerData['Lat'], _offerData['Long'])
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          child: GoogleMap(
            markers: Set.from(allMarkers),
            initialCameraPosition:
                CameraPosition(target: LatLng(37.42200058560960000000, -122.08400286734100000000), zoom: 15),
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
    var response = await Api().getData('/API/products/${widget.id}/');
    if (response.statusCode == 200) {
      setState(() {
        _offerData = json.decode(response.body);
        print(_offerData);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
