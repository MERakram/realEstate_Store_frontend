import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/RecomendedCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/agencyProfileComponent/agencyDescription.dart';
import '../server/api.dart';

String phoneNumber = '+213776785800';
final url = 'tel:$phoneNumber';
void _launchURL() async {
  if (!await launch(url)) throw 'Could not launch $url';
}

class agencyDescriptionPage extends StatefulWidget {
  int id;
  agencyDescriptionPage(this.id);
  @override
  _agencyDescriptionPageState createState() {
    return _agencyDescriptionPageState();
  }
}

class _agencyDescriptionPageState extends State<agencyDescriptionPage> {
  var _OwnerDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOwnerDetails()
    ;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 27,
                    ),
                    margin: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
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
                    height: 50,
                    width: 50,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: width*0.12,
                ),
                Text(
                  "Agency Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: width*0.12,
                ),
                GestureDetector(
                    child: Container(
                      child: const Icon(
                        Icons.call,
                        color: Colors.black,
                        size: 30,
                      ),
                      margin: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
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
                      height: 50,
                      width: 50,
                    ),
                    onTap: () {
                      _launchURL();
                    }),
              ],
            ),
            agencyDesc(widget.id),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 5, 8),
              child: Text(
                'From same agency',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 18),
              ),
            ),
            RecommendedCard('offerPage','/API/offers'),
          ],
        ),
      ),
    );
  }
  _loadOwnerDetails() async {
    var response = await Api().getData('/auth/users/${widget.id}','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _OwnerDetails = json.decode(response.body);
        print(_OwnerDetails);
        phoneNumber=_OwnerDetails['phone'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
