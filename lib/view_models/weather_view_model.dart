import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/additional_data_model.dart';
import 'package:weather_app/models/temperature_model.dart';
import 'package:weather_app/models/weather_model.dart';

import '../utils/constants.dart';
import '../widgets/toast_messages.dart';

class WeatherViewModel extends GetxController{
  RxInt timeZoneDifference=0.obs;


   getData(String location) async {
    final url = Uri.parse(openWeatherUrl(location));
    final response = await http.get(url);
    bool isDataLoaded=handleResponse(response);
    if(isDataLoaded){
      Map body=jsonDecode(response.body);
     timeZoneDifference.value=body['timezone'];
      TemperatureModel temperatureModel=TemperatureModel.fromJson(body['main']);
      AdditionalDataModel additionalDataModel=AdditionalDataModel.fromJson(body['sys']);
      WeatherModel weatherModel=WeatherModel(
        additionalDataModel: additionalDataModel,
        temperatureModel: temperatureModel,
      );
      return weatherModel;
    }
  }
  getDataPosition(Position position) async {
    final url = Uri.parse(openWeatherUrlLatLong(position));
    final response = await http.get(url);
    bool isDataLoaded=handleResponse(response);
    if(isDataLoaded){
      Map body=jsonDecode(response.body);

      timeZoneDifference.value=body['timezone'];
      TemperatureModel temperatureModel=TemperatureModel.fromJson(body['main']);
      AdditionalDataModel additionalDataModel=AdditionalDataModel.fromJson(body['sys']);
      WeatherModel weatherModel=WeatherModel(
        additionalDataModel: additionalDataModel,
        temperatureModel: temperatureModel,
      );
      return weatherModel;
    }
  }

  handleResponse(http.Response response){
    if (response.statusCode == 200) {
      return true;
    } else {
      if(response.statusCode==404){
        normalToast("Entered City name not found");
      }else if(response.statusCode==400){
        normalToast("Enter City Name");
      }else{
        normalToast("Error! Cannot Load Data");
      }
      return false;
    }

  }
}