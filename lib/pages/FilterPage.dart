import 'dart:convert';

import 'package:flutter/material.dart';

import '../component/homePageComponent/RecomendedCard.dart';

class FilterPage extends StatefulWidget {
  Map <String, String> parametres;
  FilterPage(this.parametres);
  @override
  _FilterPageState createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
    if(widget.parametres['propretytype']==null)
      widget.parametres['propretytype']='';
    if(widget.parametres['minprice']==null)
      widget.parametres['minprice']='';
    if(widget.parametres['maxprice']==null)
      widget.parametres['maxprice']='';
    if(widget.parametres['roomnumber']==null)
      widget.parametres['roomnumber']='';
    if(widget.parametres['dealtype']==null)
      widget.parametres['dealtype']='';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
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
                      width: width*0.03,
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
                                  color:
                                      const Color(0xFF605F5F).withOpacity(0.1),
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
                      width: width*0.08,
                    ),
                    Text(
                      'Filtered Search',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                 RecommendedCard('offerPage',
                    '/API/offers/?price__lt=${widget.parametres['maxprice']}&price__gt=${widget.parametres['minprice']}&categories=${widget.parametres['propretytype']}&whatfor=${widget.parametres['dealtype']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
