import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oued_kniss1/component/SearchBar.dart';
import 'package:oued_kniss1/component/homePageComponent/categories.dart';
import 'package:oued_kniss1/component/homePageComponent/dropdownbutton.dart';
import 'package:oued_kniss1/pages/AgencyProfile.dart';
import 'package:oued_kniss1/pages/OfferPage.dart';
import 'package:oued_kniss1/pages/SearchPage.dart';
import 'package:oued_kniss1/pages/mapSearch.dart';
import '../component/homePageComponent/RecomendedCard.dart';
import '../component/homePageComponent/SmallCard.dart';
import '../component/snackBar.dart';
import '../server/api.dart';
import 'CostumerProfile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? lastPressed;
  int _selectedIndex = 0;
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
            onWillPop: () async {
              final now = DateTime.now();
              final maxDuration = Duration(seconds: 2);
              final isWarning =
                  lastPressed == null || now.difference(lastPressed!) > maxDuration;
              if (isWarning) {
                lastPressed = DateTime.now();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Stack(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(16),
                //           height: 70,
                //           decoration: BoxDecoration(
                //             color: Color(0xFFC72C41),
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(20),
                //             ),
                //           ),
                //           child: Row(
                //             children: [
                //               SizedBox(
                //                 width: 48,
                //               ),
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Oh Snap",
                //                       style: TextStyle(
                //                         fontSize: 18,
                //                         color: Colors.white,
                //                       ),
                //                     ),
                //                     Text(
                //                       'check your login/connection',
                //                       style: TextStyle(
                //                         fontSize: 14,
                //                         color: Colors.white,
                //                       ),
                //                       maxLines: 2,
                //                       overflow: TextOverflow.ellipsis,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //     behavior: SnackBarBehavior.floating,
                //     backgroundColor: Colors.transparent,
                //     elevation: 0,
                //   ),
                // );
                showWarningSnackBar(context,"hello");
                return false;
              } else {
                SystemNavigator.pop();
                return true;
              }
            },
        child: MaterialApp(
          home:  Scaffold(
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
                                  ? const Center(
                                      child: Text(
                                        'Loading',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    )
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
                            MaterialPageRoute(builder: (context) => mapSearch()),
                          );
                        },
                        child: Container(
                          child: const Icon(
                            Icons.my_location,
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
                            if (_profileData['account_type'] == 'Agency') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AgencyProfile()),
                              );
                            } else
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CostumerProfile()),
                              );
                          },
                          child: Container(
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundImage: _profileData == null
                                    ? NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                                    : NetworkImage(_profileData['avatar']),
                                backgroundColor: Colors.transparent,
                              ),
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
                              // categories(),
                              Row(
                                children: [
                                  searchBar(),
                                  // Container(color: Colors.black,width: 30,)
                                ],
                              ),
                              // SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Latest',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              RecommendedCard('offerPage', '/API/products'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'See More',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SmallCard(),
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
        ),
      ),
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
    var response = await Api().getData('/auth/users/me/', 'JWT');
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

  Future _onRefresh() async {
    return;
  }
}
