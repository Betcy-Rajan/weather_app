import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/services/location_services.dart';


class LocationController extends GetxController {
  Position ? _currentPosition;
  Position ? get currentPosition => _currentPosition;
  final LocationServices _locationServices = LocationServices();
  // final WeatherService _weatherService = WeatherService();
  Placemark ? _currentLocationName;
  Placemark ? get currentLocationName => _currentLocationName;
  RxString  locationName = 'Loading'.obs;

  Future<void> getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _currentPosition = null;
        Get.snackbar(
          "Alert", // title of the snackbar
          "Location is not enabled", // message
          snackPosition: SnackPosition.BOTTOM, // position of the snackbar
          backgroundColor: Colors.blue, // background color
          colorText: Colors.white, // text color
          duration: const Duration(seconds: 3), // duration for how long the snackbar is shown
        );
        return;
      }
      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied){
          _currentPosition = null;
          Get.snackbar(
            "Alert", // title of the snackbar
            "Location permission is denied", // message
            snackPosition: SnackPosition.BOTTOM, // position of the snackbar
            backgroundColor: Colors.blue, // background color
            colorText: Colors.white, // text color
            duration: const Duration(seconds: 3), // duration for how long the snackbar is shown
          );
          return;
        }
      }
      if(permission == LocationPermission.deniedForever){
        _currentPosition = null;
        Get.snackbar(
          "Alert", // title of the snackbar
          "Location permission is denied forever", // message
          snackPosition: SnackPosition.BOTTOM, // position of the snackbar
          backgroundColor: Colors.blue, // background color
          colorText: Colors.white, // text color
          duration: const Duration(seconds: 3), // duration for how long the snackbar is shown
        );
        return;
      }
      _currentPosition = await Geolocator.getCurrentPosition();
       _currentLocationName = await _locationServices.getLocationName(_currentPosition);
    
    
    //   double lat = _currentPosition!.latitude;
    // double lon = _currentPosition!.longitude;
      
      print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
  
      print(_currentLocationName?.locality);
      if(_currentLocationName != null) {
        locationName.value = _currentLocationName!.locality ?? 'Unknown Location';
      }
      // locationName.value = _currentLocationName!.locality.toString();
      // // if(_currentLocationName != null){
      //   locationName.value = _currentLocationName!.locality.toString();
      // }
//       if (_currentLocationName != null) {
//     locationName.value = _currentLocationName!.locality ?? 'Unknown Location';
// } else {
//     locationName.value = 'Unable to fetch location';
// }

      // print(_currentPosition);
      Get.snackbar(
        "Success", // title of the snackbar
        "Location fetched successfully", // message
        snackPosition: SnackPosition.BOTTOM, // position of the snackbar
        backgroundColor: Colors.blue, // background color
        colorText: Colors.white, // text color
        duration: const Duration(seconds: 3), // duration for how long the snackbar is shown
      );

  }
}