import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/Comments.dart';
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
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            Stack(
              children: [
                OfferImage(),
                Positioned(
                  left: 13,
                  top: 18,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                        ),
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
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: agencyMiniProfile(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => agencyDescriptionPage()),
                );
              },
            ),
            offerDescription(),
            offerMap(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: TextField(
                maxLength: 50,
                maxLines: 2,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.send,color: Color(0xFFCDB889),),
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCDB889)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'what do u think?',
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            Comments(),
          ],
        ),
      ),
    );
  }
}
