import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/SearchBar.dart';

import '../component/FilterSheet.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
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
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
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
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'filter',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              searchBar(),
              ElevatedButton(onPressed:(){
                showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) =>
                        FilterOffer(context: context));
              }
                  , child: Text('hello'))
            ],
          ),
        ),
      ),
    );
  }
}
