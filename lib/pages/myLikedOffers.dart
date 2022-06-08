import 'package:flutter/material.dart';

import '../component/LikedCard.dart';
import '../component/homePageComponent/RecomendedCard.dart';
import 'CostumerProfile.dart';
import 'OfferPage.dart';

class myLikedOffers extends StatefulWidget {
  int id;
  myLikedOffers(this.id);
  @override
  _myLikedOffersState createState() {
    return _myLikedOffersState();
  }
}

class _myLikedOffersState extends State<myLikedOffers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                          ),
                          height: 45,
                          width: 45,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 27,
                              ),
                            ),
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
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CostumerProfile(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Liked Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                LikedCard('OfferPage','/API/offersbyowner'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}