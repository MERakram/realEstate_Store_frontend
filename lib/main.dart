import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oued_kniss1/pages/AgencyProfile.dart';
import 'package:oued_kniss1/pages/CostumerProfile.dart';
import 'package:oued_kniss1/pages/addOffer.dart';
import 'package:oued_kniss1/pages/agencyDescription.dart';
import 'package:oued_kniss1/pages/loginPage.dart';
import 'package:oued_kniss1/pages/pagesFrame.dart';

import 'main2.dart';


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
