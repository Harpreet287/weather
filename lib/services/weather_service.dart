import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class WeatherService{
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apikey;
  WeatherService(this.apikey);
  Future<Weather> getWeather(String city_name)async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$city_name&appid=$apikey&units=metric'));
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));

    }
    else{
      throw Exception("failed");
    }
  }
  Future<String> getCurrentCity()async{
    LocationPermission permission = await(Geolocator.checkPermission());
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    // fetch cur location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // convert location to placemark object
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    if(city!=null) return city;
    return "";
    //extract city name!!
  }
}