import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location {
   determinePosition() async {
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      print('long = ${position.longitude}');
      print('lat = ${position.latitude}');
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String? country = placemarks[0].country;
      String?  locality = placemarks[0].locality;
      print(country);
      print(locality);
return position;
    }
    catch(e){
      throw e;
    }
  }
}