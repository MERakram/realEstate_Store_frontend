import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';

import '../../pages/OfferPage.dart';
import '../../server/api.dart';
import '../SmallHouseImage.dart';
import 'forSale.dart';

class SmallCard extends StatefulWidget {
  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  var _offers = [];
  bool _isLoading = false;
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
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(parent: null),
              shrinkWrap: true,
              itemCount: _offers.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OfferPage(_offers[index]['id'])),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 07, 10, 7),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 10,
                            child: SizedBox(
                              child: SmallHouseImage(),
                              width: 130,
                            ),
                          ),
                          Flexible(
                            flex: 16,
                            child: Container(
                              color: Colors.white,
                              padding:
                                  // EdgeInsets.fromLTRB(left, top, right, bottom)
                                  const EdgeInsets.fromLTRB(10, 1, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _offers[index]['whatfor'] == 'for_rent'
                                      ? ForRent()
                                      : ForSale(),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    _offers[index]['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    _offers[index]['Location'],
                                    softWrap: true,
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
                                      children:  [
                                        CircleAvatar(
                                          backgroundColor: Color(0x34CDB889),
                                          radius: 15,
                                          child: Icon(Icons.bed_rounded,color: Colors.black,),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _offers[index]['rooms'],
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
                                          _offers[index]['size'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),

                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  _offers[index]['whatfor']=='for_rent'?
                                  Text(
                                    '\$ ${_offers[index]['price'].toString()} / day',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ):Text(
                                    '\$ ${_offers[index]['price'].toString()}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      height: height * 0.24,
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
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
                );
              },
            ),
    );
  }

  _loadOffers() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Api().getData('/API/products');
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
