import 'package:weather_app/models/additional_data_model.dart';
import 'package:weather_app/models/temperature_model.dart';

class WeatherModel {
  TemperatureModel? temperatureModel;
  AdditionalDataModel? additionalDataModel;

  WeatherModel({this.temperatureModel,this.additionalDataModel});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temperatureModel = json['temperatureModel'];
    additionalDataModel=json['additionalDataModel'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['temperatureModel']=temperatureModel;
    data['additionalDataModel']=additionalDataModel;
    return data;
  }
}