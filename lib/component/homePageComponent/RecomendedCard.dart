import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';
import 'package:oued_kniss1/component/homePageComponent/forSale.dart';
import 'package:oued_kniss1/pages/editOfferPage.dart';

import '../../pages/OfferPage.dart';
import '../../server/api.dart';
import '../BigHouseImage.dart';

class RecommendedCard extends StatefulWidget {
  String destination;
  String url;
  RecommendedCard(this.destination, this.url);
  @override
  State<RecommendedCard> createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {
  bool _isLoading = false;
  var _offers = [];
  var _offersIDs = [];

  @override
  void initState() {
    super.initState();
    loadOffersR();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return SizedBox(
      height: height * 0.52,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(parent: null),
              shrinkWrap: true,
              itemCount: _offers.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(12, 1, 12, 5),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.destination == 'offerPage') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OfferPage(_offers[index]['id'])),
                      );
                    } else if (widget.destination == 'editOfferPage') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  editOfferPage(_offers[index]['id'])));
                    } else
                      return;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          BigHouseImage(_offers[index]['id']),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18, 1, 12, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _offers[index]['whatfor'] == 'for_rent'
                                    ? ForRent()
                                    : ForSale(),
                                // const SizedBox(
                                //   height: 2,
                                // ),
                                // Text(
                                //   _offers[index]['title'],
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 20,
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _offers[index]['Location'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      if(_offers[index]['categories'] != 'Land')
                                        CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 15,
                                        child: Icon(
                                          Icons.bed_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                      if(_offers[index]['categories'] != 'Land')
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if(_offers[index]['categories'] != 'Land')
                                      Text(
                                        _offers[index]['rooms'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 11,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/area.png'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _offers[index]['size'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _offers[index]['categories'],
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                _offers[index]['whatfor'] == 'for_rent'
                                    ? Text(
                                        '\$ ${_offers[index]['price'].toString()} / day',
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFCDB889),fontSize: 20),
                                      )
                                    : Text(
                                        '\$ ${_offers[index]['price'].toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFCDB889),fontSize: 20),
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
                            color: const Color(0xFF605F5F).withOpacity(0.1),
                            spreadRadius: -2,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      width: 300,
                    ),
                  ),
                );
              }),
    );
  }

  loadOffersR() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Api().getData('${widget.url}', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _offers = json.decode(response.body);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
