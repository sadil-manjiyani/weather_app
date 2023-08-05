import 'package:geolocator/geolocator.dart';

String openWeatherUrl(String location){
String url="https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$openWeatherApi&units=metric";
return url;
}


String openWeatherUrlLatLong(Position position){
  String url="https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$openWeatherApi&units=metric";
  return url;
}
String openWeatherApi="d9f5e1e040b4885048404c757bf2184c";