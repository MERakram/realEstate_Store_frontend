import 'package:flutter/material.dart';
import 'package:oued_kniss1/pages/addOffer.dart';

import '../component/homePageComponent/RecomendedCard.dart';
import 'OfferPage.dart';
import 'editOfferPage.dart';

class myOffersPage extends StatefulWidget {
  int id;
  myOffersPage(this.id);
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                          ),
                          height: 45,
                          width: 45,
                          child: Container(
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
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'my Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                RecommendedCard('editOfferPage','/API/productsbyowner'),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addOfferPage(widget.id)),
                    );
                  },
                  child: Container(
                    width: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFCDB889),
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
