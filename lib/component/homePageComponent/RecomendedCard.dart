import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';

import '../../api.dart';
import '../BigHouseImage.dart';

class RecommendedCard extends StatefulWidget {
  @override
  State<RecommendedCard> createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {

  var _offers = [];

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return SizedBox(
      height: height * 0.51,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: null),
          shrinkWrap: true,
          itemCount: _offers.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(12, 1, 12, 5),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    BigHouseImage(),
                    Padding(
                      padding:
                          // EdgeInsets.fromLTRB(left, top, right, bottom)
                          const EdgeInsets.fromLTRB(18, 1, 12, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ForRent(),
                          const SizedBox(
                            height: 2,
                          ),
                           Text(
                             _offers[index]['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                           Text(
                             _offers[index]['description'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Container(
                            child: Row(
                              children: const [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 13,
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'FO',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 13,
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'FO',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 13,
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'FO',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Text(
                            '\$ ${_offers[index]['price'].toString()} / day',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
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
                width: 300,
              ),
            );
          }),
    );
  }
  _loadOffers() async {
    var response = await Api().getData('/product');
    if (response.statusCode == 200) {
      setState(() {
        _offers = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
