import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';

import '../../api.dart';
import '../SmallHouseImage.dart';


class SmallCard extends StatefulWidget {
  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: null),
      shrinkWrap: true,
      itemCount:_offers.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 07, 10, 7),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(flex: 10,
                  child: SizedBox(
                    child: SmallHouseImage(),
                    width: 130,
                  ),
                ),
                Flexible(flex:16 ,
                  child: Container(color: Colors.white,
                    padding:
                        // EdgeInsets.fromLTRB(left, top, right, bottom)
                        const EdgeInsets.fromLTRB(10, 1, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ForRent(),
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
                           _offers[index]['description'],
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
                ),
              ],
            ),
            height: height * 0.22,
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF605F5F).withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _loadOffers() async {
    var response = await Api().getData('/API/products');
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
