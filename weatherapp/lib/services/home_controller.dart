
import 'package:get/get.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/weather_services_controller.dart';

class HomeController extends GetxController {
  static LocationController get locationInstance => Get.find();
  static WeatherServicesController get weatherInstance => Get.find();

  var isLoading = true.obs; // Observable for loading state
  var hasError = false.obs; // Observable for error state

  @override
  void onInit() async {
    super.onInit();
    try {
      // Fetch the user's current location
      await locationInstance.getCurrentLocation();

      // // Check if location is available
      // // var location = locationInstance.currentLocationName?.locality ?? ''; // Use null-safe access
      // // print("Location: $location");

      // if (locationInstance.currentPosition != null) {
      //   // Fetch weather data for the current location
       
      //   await weatherInstance.fetchWeatherDataByCity('Kollam');
      // } else {
      //   // Fallback to a default city like 'dubai'
      //   await weatherInstance.fetchWeatherDataByCity('dubai');
      // }


      if (locationInstance.currentPosition != null) {
       double lat = locationInstance.currentPosition!.latitude;
      print(lat);
      double lon = locationInstance.currentPosition!.longitude;
      print(lon);
       print("Fetching weather data for: $lat, $lon");
        await weatherInstance.fetchWeatherDataByLocation(lat, lon);
      }
      
      
        // Fetch weather data for the current location
       
   

      hasError(false); // No error
    } catch (e) {
      // Handle any errors
      hasError(true);
      print("Error fetching location or weather data: $e");
    } finally {
      isLoading(false); // Loading complete
      update(); // Notify GetX of the state change
    }
  }
}
