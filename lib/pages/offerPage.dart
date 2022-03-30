import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/ButtomNav.dart';
import '../component/offerPageComponent/agencyMiniProfile.dart';
import '../component/offerPageComponent/offerDescription.dart';
import '../component/offerPageComponent/offerMap.dart';
import '../component/offerPageComponent/offerimage.dart';

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
