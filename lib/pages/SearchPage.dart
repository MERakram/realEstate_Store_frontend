import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/SearchBar.dart';

import '../component/FilterSheet.dart';
import '../component/homePageComponent/RecomendedCard.dart';

class SearchPage extends StatefulWidget {
  String Search;
  SearchPage(this.Search);
  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    if (widget.Search==null)
      widget.Search=' ';
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
                      width: 40,
                    ),
                    Text(
                      'Filtered Search',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                RecommendedCard('offerPage',
                    '/API/offers/?search=${widget.Search}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
