import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


final phoneNumber = '+213776785800';
final url ='tel:$phoneNumber';

void main() => runApp(
  const MaterialApp(
    home: Material(
      child: Center(
        child: RaisedButton(
          onPressed: _launchURL,
          child: Text('make phone call'),
        ),
      ),
    ),
  ),
);

void _launchURL() async {
  if (!await launch(url)) throw 'Could not launch $url';
}