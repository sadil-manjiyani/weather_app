class TemperatureModel {
  double? temp;
  double? feelslike;
  double? tempmin;
  double? tempmax;
  int? pressure;
  int? humidity;

  TemperatureModel({this.temp, this.feelslike, this.tempmin, this.tempmax, this.pressure, this.humidity});

  TemperatureModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelslike = json['feels_like'];
    tempmin = json['temp_min'];
    tempmax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['temp'] = temp;
    data['feels_like'] = feelslike;
    data['temp_min'] = tempmin;
    data['temp_max'] = tempmax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}