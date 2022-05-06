import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';
import 'package:oued_kniss1/component/homePageComponent/forSale.dart';
import 'package:oued_kniss1/pages/editOfferPage.dart';

import '../../pages/OfferPage.dart';
import '../../server/api.dart';
import '../BigHouseImage.dart';

class RecommendedCard extends StatefulWidget {
  String destination;
  RecommendedCard(this.destination);
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
            child:_isLoading?Center(child: CircularProgressIndicator(),): ListView.builder(
                physics: const BouncingScrollPhysics(parent: null),
                shrinkWrap: true,
                itemCount: _offers.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 1, 12, 5),
                itemBuilder: (BuildContext context,int index) {
                  return GestureDetector(
                    onTap: () {
                      if (widget.destination=='offerPage'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferPage(_offers[index]['id'])),
                      );}else if(widget.destination=='editOfferPage'){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => editOfferPage(_offers[index]['id'])));
                      }else return;
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
                                    // _offers[index]['description'],
                                    'hello',
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
                                          backgroundColor: Color(0x34CDB889),
                                          radius: 15,
                                          child: Icon(Icons.bed_rounded,color: Colors.black,),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '4',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Color(0x34CDB889),
                                          radius: 15,
                                          child: Icon(Icons.camera),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'FO',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Color(0x34CDB889),
                                          radius: 13,
                                          child: Icon(Icons.add),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'FO',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                              color: const Color(0xFF605F5F).withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                             offset: Offset(2, 1),
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

  _loadOffers() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Api().getData('/API/products');
    if (response.statusCode == 200) {
      setState(() {
          _isLoading=false;
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
