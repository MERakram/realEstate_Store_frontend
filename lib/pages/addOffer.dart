import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/generated/l10n.dart' as location_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../api.dart';

class addOfferPage extends StatefulWidget {
  @override
  _addOfferPageState createState() {
    return _addOfferPageState();
  }
}

class _addOfferPageState extends State<addOfferPage> {
  String _platformVersion = 'Unknown';
  LocationResult? _pickedLocation;
  LatLng? location;
  double? latitude, longitude;
  String? country, locality, name, street, address;
  String dropdown1Value = 'for sale',dropdown2Value = 'appartement',locationtext = "Select Location";
  var user_id = 1,title,price,description,categories = [];
  String category_id = "2";
  File? image;
  List<File> multipleImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // _loadCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed $e');
    }
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await MapLocationPicker.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    void determinePosition() async {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude!, longitude!);
        setState(() {
          country = placemarks[0].country;
          locality = placemarks[0].locality;
          street = placemarks[0].street;
          name = placemarks[0].name;
          address = "${country} , ${locality} , ${street}";
        });
        print(country);
        print(locality);
        print(name);
      } catch (e) {
        throw e;
      }
    }

    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        location_picker.S.delegate,
      ],
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ADD OFFER',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Title',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Price',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        price = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      maxLength: 170,
                      maxLines: 3,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 20, 0, 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Description',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 50,
                        width: 170,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: DropdownButton<String>(
                            value: dropdown1Value,
                            underline: SizedBox(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 16,
                            style: const TextStyle(
                              color: Color(0xFF5F5F5F),
                            ),
                            iconSize: 30,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdown1Value = newValue!;
                              });
                            },
                            items: <String>['for sale', 'for rent']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(value),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 50,
                        width: 170,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: DropdownButton<String>(
                            value: dropdown2Value,
                            underline: SizedBox(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 16,
                            style: const TextStyle(
                              color: Color(0xFF5F5F5F),
                            ),
                            iconSize: 30,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdown2Value = newValue!;
                              });
                            },
                            items: <String>[
                              'appartement',
                              'house',
                              'industrial',
                              'commercial',
                              'Land'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(value),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 170,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFCDB889)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Surface              m²',
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 50,
                        width: 170,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFCDB889)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Rooms',
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      LocationResult? result = await showLocationPicker(
                        context,
                        'AIzaSyBQByMa90Ng0VQw-4WsVazBWK7831DsIyI',
                        initialCenter: const LatLng(31.1975844, 29.9598339),
                        myLocationButtonEnabled: true,
                        // layersButtonEnabled: true,
                        resultCardConfirmIcon:
                            Icon(Icons.keyboard_arrow_up_rounded),
                        resultCardPadding: EdgeInsets.all(0),
                        desiredAccuracy: LocationAccuracy.bestForNavigation,
                        countries: ['IN'],
                        language: 'en',
                        // requiredGPS: true,
                      );
                      // debugPrint("result = $result");
                      setState(() {
                        _pickedLocation = result;
                        location = result?.latLng;
                        latitude = location?.latitude;
                        longitude = location?.longitude;
                        determinePosition();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                        height: 60,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Center(
                              child: Text(country.toString() == 'null'
                                  ? locationtext
                                  : address.toString())),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // GestureDetector(
                  //   onTap: pickImage,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 25,
                  //     ),
                  //     child: Container(
                  //       height: 60,
                  //       width: 360,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey[200],
                  //         border: Border.all(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.all(0),
                  //         child: Center(
                  //             child: image != null
                  //                 ? Image.file(image!)
                  //                 : Text('Pick image')),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      List<XFile>? picked = await _picker.pickMultiImage(
                          maxWidth: 50, maxHeight: 50);
                      setState(() {
                        multipleImages =
                            picked!.map((e) => File(e.path)).toList();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                        height: 60,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Center(
                              child:multipleImages.length != 0? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: multipleImages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.file(multipleImages[index]);
                                  },):Text('pick images')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _submit,
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFCDB889),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  _loadCategories() async {
    var response = await Api().getData('/category');
    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }

  void _submit() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var data = new Map<String, String>();
    data['title'] = title;
    data['price'] = price;
    //data['user_id'] = user_id.toString();

    data['description'] = description;

    // data['image'] = _image.path;

    //var response = await Api().postDataWithImage(data, '/offers', _image.path);
    var response = await Api().postData(data,'/API/products/');

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      _showMsg('Error ${response.statusCode}');
    }
  }

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
  }
}
