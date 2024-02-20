import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/service/model/weather.dart';
import 'package:weather/service/weather_api.dart';

class WeatherProvider extends ChangeNotifier {
  final weatherApi = WeatherApi();

  double _latitude = 0.0;
  double _longitude = 0.0;
  bool _isLoading = true;

  Weather _weather = Weather();

  bool get isLoading => _isLoading;

  Weather get weather => _weather;

  void getUserLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // update our lattitude and longitude
      _latitude = value.latitude;
      _longitude = value.longitude;
      // calling our weather api
      return WeatherApi()
          .getWeatherData(lat: value.latitude, long: value.longitude)
          .then((value) {
        if (value == null) return;
        _weather = value;
        _isLoading = false;
        notifyListeners();
      });
    });
  }
}
