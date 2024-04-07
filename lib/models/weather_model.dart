class Weather{
  final String city_name;
  final double temperature;
  final String main_condition;
  Weather({
required this.city_name, required this.temperature, required this.main_condition
  });
  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(city_name: json['name'], temperature: json['main']['temp'].toDouble(), main_condition: json['weather'][0]['main'],);
  }
}