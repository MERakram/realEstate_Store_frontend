import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/RecomendedCard.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerMap.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerimage.dart';
import 'package:oued_kniss1/pages/agencyDescription.dart';
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
            Stack(
              children: [
                OfferImage(),
                Positioned(
                  left: 13,
                  top: 18,
                  child: GestureDetector(
                    child: BlurryContainer(
                      blur: 50,
                      borderRadius: BorderRadius.circular(10),
                      bgColor: const Color(0x00eee1cf),
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 45,
                      width: 45,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                ),
              ],
            ),
            GestureDetector(child: agencyMiniProfile(),onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => agencyDescriptionPage()),
              );
            },),
            offerDescription(),
            offerMap(),
          ],
        ),
      ),
    );
  }
}
