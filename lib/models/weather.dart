import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String city;
  final String icon;
  final num temp;
  final String weather;
  final String description;
  final num windSpeed;
  final num pressure;
  final num humidity;
  final num feelsLike;
  final DateTime dateTime;

  const Weather({
    required this.city,
    required this.icon,
    required this.temp,
    required this.weather,
    required this.description,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
    required this.feelsLike,
    required this.dateTime,
  });

  factory Weather.initial() => Weather(
        city: '',
        icon: '',
        temp: 0,
        weather: '',
        description: '',
        windSpeed: 0,
        pressure: 0,
        humidity: 0,
        feelsLike: 0,
        dateTime: DateTime(0),
      );

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      weather: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      feelsLike: json['main']['feels_like'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  @override
  String toString() {
    return 'Weather(city: $city, icon: $icon, temp: $temp, weather: $weather, description: $description, windSpeed: $windSpeed, pressure: $pressure, humidity: $humidity, feelsLike: $feelsLike, dateTime: $dateTime)';
  }

  @override
  List<Object?> get props => [
        city,
        icon,
        temp,
        weather,
        description,
        windSpeed,
        pressure,
        humidity,
        feelsLike,
        dateTime,
      ];
}
