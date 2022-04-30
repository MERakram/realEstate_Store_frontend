import 'dart:convert';

import 'package:flutter/material.dart';

import 'api.dart';
void main() {
  runApp(MaterialApp( home : testAPI(),
    debugShowCheckedModeBanner: false,
  ),);

}
class testAPI extends StatefulWidget {


  @override
  _testAPIState createState() {
    return _testAPIState();
  }
}

class _testAPIState extends State<testAPI> {
  var _offers = [];
  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              child: Text("getdata"),
              onPressed: () {
                _loadOffers();
              }),

        ),
      ),
    );
  }
  _loadOffers() async {
    var response = await Api().getData('/product');
    if (response.statusCode == 200) {
      setState(() {
        _offers = json.decode(response.body);
        print(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}