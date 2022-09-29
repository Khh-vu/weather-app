class Weather {
  final String country;
  final String icon;
  final double temp;
  final String weather;
  final String description;
  final double windSpeed;
  final double windGust;
  final double pressure;
  final int humidity;
  final int visibility;
  final double feelsLike;
  final DateTime dateTime;

  Weather({
    required this.country,
    required this.icon,
    required this.temp,
    required this.weather,
    required this.description,
    required this.windSpeed,
    required this.windGust,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.feelsLike,
    required this.dateTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      country: json['name'],
      icon: json['weather']['icon'],
      temp: json['main']['temp'],
      weather: json['weather']['main'],
      description: json['weather']['description'],
      windSpeed: json['wind']['speed'],
      windGust: json['wind']['gust'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      feelsLike: json['main']['feels_like'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dt'] * 1000000),
    );
  }
}
