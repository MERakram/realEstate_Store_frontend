import 'dart:convert';
import 'dart:ffi';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oued_kniss1/component/homePageComponent/SmallCard.dart';
import 'package:oued_kniss1/pages/OfferPage.dart';

import '../component/SmallHouseImage.dart';
import '../component/homePageComponent/forRent.dart';
import '../server/api.dart';

class mapSearch extends StatefulWidget {
  static const Marker _offermarker = Marker(
      markerId: MarkerId('_offermarker'),
      infoWindow: InfoWindow(title: 'offer'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42200058560960000000, -122.08400286734100000000));
  @override
  _mapSearchState createState() {
    return _mapSearchState();
  }
}

class _mapSearchState extends State<mapSearch> {
  late BitmapDescriptor mapMarker;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> allMarkers = [];
  var _offerData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getloc(context));
    _loadData();
    setCustomMarker();
  }

  Position? position = null;
  double? lat = null;
  double? long = null;
  getloc(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      // print('long = ${position.longitude}');
      // print('lat = ${position.latitude}');
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      throw e;
    }
  }
  void setCustomMarker()async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/pin2.png');
  }
  @override
  Widget build(BuildContext context) {
    while (lat == null) {
      return CircularProgressIndicator();
    }
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _customInfoWindowController.googleMapController = controller;
          },
          markers: allMarkers == null
              ? {mapSearch._offermarker}
              : Set.from(allMarkers),
          initialCameraPosition:
              CameraPosition(target: LatLng(lat!, long!), zoom: 15),
          zoomGesturesEnabled: true,
          onTap: (position){_customInfoWindowController.hideInfoWindow!();},
          onCameraMove: (position){_customInfoWindowController.onCameraMove!();},
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 150,
          width: 350,
          offset: 35,
        )
      ],
    );
  }

  _loadData() async {
    var response = await Api().getData('/API/products/');
    if (response.statusCode == 200) {
      setState(() {
        _offerData = json.decode(response.body);
        // print(_offerData);
        for (int i = 0; i < _offerData.length; i++) {
          allMarkers.add(
            Marker(
              markerId: MarkerId(_offerData[i]['id'].toString()),
              draggable: false,
              position: LatLng(
                double.parse(_offerData[i]['Lat']),
                double.parse(
                  _offerData[i]['Long'],
                ),
              ),
              icon: mapMarker,
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                  GestureDetector(onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferPage(_offerData[i]['id'])),
                    );
                  },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 07, 10, 7),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: SizedBox(
                                child: SmallHouseImage(),
                                width: 130,
                              ),
                            ),
                            Flexible(
                              flex: 16,
                              child: Container(
                                color: Colors.white,
                                padding:
                                // EdgeInsets.fromLTRB(left, top, right, bottom)
                                const EdgeInsets.fromLTRB(10, 1, 0, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ForRent(),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      _offerData[i]['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      // _offers[index]['description'],
                                      'hello',
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      child: Row(
                                        children: const [
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 13,
                                            child: Icon(Icons.add),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'FO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 13,
                                            child: Icon(Icons.add),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'FO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 13,
                                            child: Icon(Icons.add),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'FO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '\$ ${_offerData[i]['price'].toString()} / day',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        height: 150,
                        margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF605F5F).withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(2, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  LatLng(
                    double.parse(_offerData[i]['Lat']),
                    double.parse(
                      _offerData[i]['Long'],
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
