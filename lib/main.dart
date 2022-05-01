import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oued_kniss1/pages/loginPage.dart';




void main() {

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
    MaterialApp( home : loginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
