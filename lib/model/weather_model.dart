class WeatherModel {
  String? temperature;
  String? windSpeed;
  String? aboutWeather;
  String? icon;
  String? humidity;
  double? windDegree;
  String? name;
  String? weatherCondition;

  WeatherModel({
    this.temperature,
    this.windSpeed,
    this.aboutWeather,
    this.name,
    this.icon,
    this.humidity,
    this.windDegree,
    this.weatherCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature:
          ((json['main']['temp'].toDouble()) - 273.15).toStringAsFixed(0),
      name: json['name'].toString(),
      windSpeed: json['wind']['speed'].toStringAsFixed(0),
      windDegree: double.parse(json['wind']['deg'].toString()),
      aboutWeather: json['weather'][0]['description'].toString().toUpperCase(),
      icon: json['weather'][0]['icon'].toString(),
      humidity: json['main']['humidity'].toString(),
      weatherCondition: json['weather'][0]['main'].toString(),
    );
  }
}
