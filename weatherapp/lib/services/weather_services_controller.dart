
import 'dart:convert';

import 'package:get/get.dart';
import 'package:weatherapp/models/weather_response.dart';
import 'package:weatherapp/secrets/api.dart';
import "package:http/http.dart" as http;

class WeatherServicesController extends GetxController {
  WeatherModel? _weatherModel;
  WeatherModel?   get weatherModel => _weatherModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = "";
  String get error => _error;
  RxDouble temperature = 0.0.obs;
  RxDouble tempMax = 0.0.obs;
  RxDouble tempMin = 0.0.obs;
  RxString weatherDescription = "Snow".obs;


  // RxString locationName = 'Loading'.obs;

  Future<void> fetchWeatherDataByCity(String city) async {
    _isLoading = true;
  
    _error = "";
    update();
    // https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=acc1624f810f158c66bf7576351c2354&units=metric
    try {
      final apiUrl = "${APIEndpoints().cityUrl}$city&appid=${APIEndpoints().apikey}${APIEndpoints().unit}";
      // final apiUrl = "${APIEndpoints().cityUrl}$&appid=${APIEndpoints().apikey}${APIEndpoints().unit}";
      final response = await http.get(Uri.parse(apiUrl));
      print(apiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          print(data);
          _weatherModel = WeatherModel.fromJson(data);
          //  temperature.value = _weatherModel!.main!.temp!.toDouble();
          // tempMax.value = _weatherModel!.main!.tempMax!.toDouble();
          // tempMin.value = _weatherModel!.main!.tempMin!.toDouble();

          weatherDescription.value = _weatherModel!.weather![0].main!.toString();
          // locationName.value = _weatherModel!.name!;
          print(_weatherModel!.base);
          
          update();
        } else {
          _error = "Received null data";
        }
      } else {
        _error = "Failed to load weather data";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      update();
    }
  }
  Future<void> fetchWeatherDataByLocation(double lat, double lon) async {
    _isLoading = true;
    _error = "";
    update();
    // https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=acc1624f810f158c66bf7576351c2354&units=metric
    try {
      final apiUrl = "${APIEndpoints().longLatUrl}$lat&lon=$lon&appid=${APIEndpoints().apikey}${APIEndpoints().unit}";
      final response = await http.get(Uri.parse(apiUrl));
      print(apiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          print(data);
          _weatherModel = WeatherModel.fromJson(data);
          // locationName.value = _weatherModel!.name!;
          temperature.value = _weatherModel!.main!.temp!.toDouble();
          tempMax.value = _weatherModel!.main!.tempMax!.toDouble();
          tempMin.value = _weatherModel!.main!.tempMin!.toDouble();

          weatherDescription.value = _weatherModel!.weather![0].main!.toString();
          



          print(_weatherModel!.base);
          update();
        } else {
          _error = "Received null data";
        }
      } else {
        _error = "Failed to load weather data";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      update();
    }
  }

}


  // WeatherModel ? _weatherModel;
  // WeatherModel ? get weatherModel => _weatherModel;
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // String _error = "";
  // String get error => _error;

  // Future<void> fetchWeatherDataByCity(String city) async {
  //   _isLoading = true;
  //   _error = "";
  //   // update();
  //   // https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=acc1624f810f158c66bf7576351c2354&units=metric
  //   try {
  //     final apiUrl = "${APIEndpoints().cityUrl}$city&appid=${APIEndpoints().apikey}${APIEndpoints().unit}";
  //     final response = await http.get(Uri.parse(apiUrl));
  //     print(apiUrl);
  //     if (response.statusCode == 200) {
  //      final data = jsonDecode(response.body);
  //      print(data);

  //       _weatherModel = WeatherModel.fromJson(data);
  //       update();

  //     } else {
  //       _error = "Failed to load weather data";
  //     }

  //   } catch (e) {
  //     _error = e.toString();
  //   }
  //   finally{
  //     _isLoading = false;
  //   update();
  //   }
  // }

