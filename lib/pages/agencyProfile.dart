import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/RecomendedCard.dart';

import '../component/agencyProfileComponent/offerDescription2.dart';


class agencyProfile extends StatefulWidget {
  @override
  _agencyProfileState createState() {
    return _agencyProfileState();
  }
}

class _agencyProfileState extends State<agencyProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: ListView(
          children: [
            offerDescription2(),
            RecommendedCard(),
          ],
        ),
      ),
    );
  }
}
