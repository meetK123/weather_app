import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/common/helper.dart';
import 'package:weather/service/model/weather_respose.dart';
import 'package:weather/service/weather_api.dart';
import 'package:geocoding/geocoding.dart';

class WeatherProvider extends ChangeNotifier {
  final weatherApi = WeatherApi();

  double _latitude = 0.0;
  double _longitude = 0.0;
  bool _isLoading = true;
  String? _locality = '';
  String? _subLocality = '';

   WeatherResponse _weather = WeatherResponse();

  bool get isLoading => _isLoading;

  WeatherResponse get weather => _weather;

  String get city => _locality ??'';
  String get area => _subLocality??'';


  void getUserLocation(BuildContext context) async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled
    if (!isServiceEnabled) {
    if(!context.mounted)return;
    Helper().scaffoldMessage(context,'Location not enabled');
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      if(!context.mounted)return;
      Helper().scaffoldMessage(context,'Location permission are denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {

        //return Future.error("Location permission is denied");
        if(!context.mounted)return;
        Helper().scaffoldMessage(context,'Location permission is denied');
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // update our lattitude and longitude
      _latitude = value.latitude;
      _longitude = value.longitude;
      getLocality();
      // calling our weather api
      return WeatherApi()
          .getWeatherData(context,lat: value.latitude, long: value.longitude)
          .then((value) {
        if (value == null) return;
        _weather = value;
        _isLoading = false;
        notifyListeners();
      });
    });
  }

  void getLocality()  async{
    List<Placemark> placemarks =
        await placemarkFromCoordinates(_latitude, _longitude);
    Placemark placemark = placemarks[0];
    _locality =  placemark.locality ??'';
    _subLocality =  placemark.subLocality ??'';

    notifyListeners();
  }
}
