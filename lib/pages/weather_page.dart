import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  //fetch weather
  String apikey = '1be96b51221dd7a90aa9cd942635d1d3';
  final _weatherService = WeatherService('1be96b51221dd7a90aa9cd942635d1d3');
  Weather? _weather;
  _fetchWeather() async{
    String city_name = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(city_name);
      setState((){
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition)
{
  if(mainCondition==null) return './assets/sun.json';
  switch(mainCondition.toLowerCase()){
    case 'clouds': return './assets/cloud.json';
    case 'mist':
    case 'haze':
    case 'smoke':
    case 'dust':
    case 'fog': return './assets/cloud.json';
    case 'clear': return './assets/sun.json';
    default:
    return './assets/sun.json';
  }
}
  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(_weather?.city_name??"loading city.."),
          Text('${_weather?.temperature.round().toString()}°C'),
          Lottie.asset(getWeatherAnimation(_weather?.main_condition)),],
        ),
      )
    );
  }
}