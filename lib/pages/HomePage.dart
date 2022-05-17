import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oued_kniss1/component/homePageComponent/categories.dart';
import 'package:oued_kniss1/component/homePageComponent/dropdownbutton.dart';
import 'package:oued_kniss1/pages/AgencyProfile.dart';
import 'package:oued_kniss1/pages/OfferPage.dart';
import 'package:oued_kniss1/pages/SearchPage.dart';
import '../component/homePageComponent/RecomendedCard.dart';
import '../component/homePageComponent/SmallCard.dart';
import '../server/api.dart';
import 'CostumerProfile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

Future<HomePage> _onRefresh() async {
  return HomePage();
}

class _HomePageState extends State<HomePage> {
  var _profileData;
  String? _country;
  @override
  void initState() {
    super.initState();
    determinePosition();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: const Color(0xFFF1F1F1),
        backgroundColor: const Color(0xFFF5F7F9),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        "Location",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 30,
                        width: 150,
                        child: _country == null
                            ? dropdownbutton()
                            : Center(
                                child: Text(
                                _country.toString(),
                                style: TextStyle(color: Colors.black),
                              )),
                        // color: Colors.white,
                      ),
                    ],
                  ),
                ),
                toolbarHeight: 65,
                collapsedHeight: 65,
                floating: true,
                // backgroundColor: const Color(0xFFF1F1F1),
                backgroundColor: const Color(0xFFF5F7F9),
                leadingWidth: 70,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchPage()),
                    );
                  },
                  child: Container(
                    child: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 3, 0, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white,
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
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if(_profileData['account_type']=='Agency'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyProfile()),
                      );}else Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CostumerProfile()),
                      );
                    },
                    child: Container(
                      // padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/img.png'),
                      ),
                      width: 52,
                      margin: const EdgeInsets.fromLTRB(0, 3, 17, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
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
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        // searchBar(),
                        categories(),
                        RecommendedCard('offerPage'),
                        GestureDetector(
                          child: SmallCard(),
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OfferPage()),
                          //   );
                          // },
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: nav(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  determinePosition() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _country = placemarks[0].locality;
      });
    } catch (e) {
      throw e;
    }
  }
  _loadData() async {
    var response = await Api().getData('/auth/users/me/');
    if (response.statusCode == 200) {
      setState(() {
        _profileData = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
