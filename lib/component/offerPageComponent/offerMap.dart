import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import '../../server/api.dart';

class offerMap extends StatefulWidget {
  // double id;
  // offerMap(this.id);
  static const Marker _offermarker = Marker(
      markerId: MarkerId('_offermarker'),
      infoWindow: InfoWindow(title: 'offer'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(29.9773, 31.1325));

  @override
  State<offerMap> createState() => _offerMapState();
}

class _offerMapState extends State<offerMap> {
  var _offerData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          child: GoogleMap(
            markers: {offerMap._offermarker},
            initialCameraPosition:
                const CameraPosition(target: LatLng(29.9773, 31.1325), zoom: 15),
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
  // _loadData() async {
  //   var response = await Api().getData('/API/products/${widget.id}/');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _offerData = json.decode(response.body);
  //       print(_offerData);
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //           'Error ' + response.statusCode.toString() + ': ' + response.body),
  //     ));
  //   }
  // }
}
