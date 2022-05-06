import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/RecomendedCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/agencyProfileComponent/agencyDescription.dart';

final phoneNumber = '+213776785800';
final url = 'tel:$phoneNumber';
void _launchURL() async {
  if (!await launch(url)) throw 'Could not launch $url';
}

class agencyDescriptionPage extends StatefulWidget {
  @override
  _agencyDescriptionPageState createState() {
    return _agencyDescriptionPageState();
  }
}

class _agencyDescriptionPageState extends State<agencyDescriptionPage> {
  @override
  Widget build(BuildContext context) {
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
                  width: 65,
                ),
                Text(
                  "Agency Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 65,
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
            agencyDesc(),
            RecommendedCard('offerPage'),
          ],
        ),
      ),
    );
  }
}
