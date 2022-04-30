import 'package:flutter/material.dart';
import 'package:oued_kniss1/pages/addOffer.dart';

import '../component/homePageComponent/RecomendedCard.dart';
import 'OfferPage.dart';
import 'editOfferPage.dart';

class myOffersPage extends StatefulWidget {
  @override
  _myOffersPageState createState() {
    return _myOffersPageState();
  }
}

class _myOffersPageState extends State<myOffersPage> {
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
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios,size: 30,),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      'my Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => editOfferPage()),
                      );
                    },
                    child: RecommendedCard()),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addOfferPage()),
                    );
                  },
                  child: Container(
                    width: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'New offer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
