import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oued_kniss1/pages/pagesFrame.dart';

import 'main2.dart';


void main() {

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
    MaterialApp( home : pagesFrame(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
