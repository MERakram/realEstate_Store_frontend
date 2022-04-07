import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/RecomendedCard.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerMap.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerimage.dart';
import '../component/offerPageComponent/agencyMiniProfile.dart';
import '../component/offerPageComponent/offerDescription.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPageState createState() {
    return _OfferPageState();
  }
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: ListView(
          children: [
            OfferImage(),
            agencyMiniProfile(),
            offerDescription(),
            offerMap(),
          ],
        ),
      ),
    );
  }
}
