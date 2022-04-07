import 'package:flutter/material.dart';

import 'main3.dart';





void main() {
  runApp(
    MaterialApp( home : LoadingScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocat() async {
    Location location = Location();
    location.determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                //Get the current location
                getLocat();
              },
              child: Text('Get Location'),
            )
          ],
        ),
      ),
    );
  }
}
