import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/forRent.dart';
import 'package:oued_kniss1/component/homePageComponent/forSale.dart';
import 'package:oued_kniss1/pages/editOfferPage.dart';

import '../../pages/OfferPage.dart';
import '../../server/api.dart';
import 'BigHouseImage.dart';

class RecommCardForOwner extends StatefulWidget {
  int id;
  String destination;
  String url;
  RecommCardForOwner(this.destination,this.url,this.id);
  @override
  State<RecommCardForOwner> createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommCardForOwner> {
  bool _isLoading = false;
  var _offers = [];
  var _displayedOffers = [];

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
                        // EdgeInsets.fromLTRB(left, top, right, bottom)
                        const EdgeInsets.fromLTRB(18, 1, 12, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              _offers[index]['Location'],
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
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Color(0x34CDB889),
                                    radius: 15,
                                    child: Icon(
                                      Icons.bed_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _offers[index]['rooms'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: Color(0x34CDB889),
                                    radius: 15,
                                    child: Icon(Icons.camera),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _offers[index]['size'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _offers[index]['whatfor'] == 'for_rent'
                                ? Text(
                              '\$ ${_offers[index]['price'].toString()} / day',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            )
                                : Text(
                              '\$ ${_offers[index]['price'].toString()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
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
    var response = await Api().getData('${widget.url}','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _offers = json.decode(response.body);
        for(int i=0;i<_offers.length;i++){
          // if(_offers['owner_id']==widget.id){
          //   _displayedOffers.add();
          // }
        }
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
