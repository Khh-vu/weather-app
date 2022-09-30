class Weather {
  final String country;
  final String icon;
  final num temp;
  final String weather;
  final String description;
  final num windSpeed;
  final num windGust;
  final num pressure;
  final num humidity;
  final num visibility;
  final num feelsLike;
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
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      weather: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'],
      windGust: json['wind']['gust'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      feelsLike: json['main']['feels_like'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dt'] * 1000000),
    );
  }

  @override
  String toString() {
    return 'Weather(country: $country, icon: $icon, temp: $temp, weather: $weather, description: $description, windSpeed: $windSpeed, windGust: $windGust, pressure: $pressure, humidity: $humidity, visibility: $visibility, feelsLike: $feelsLike, dateTime: $dateTime)';
  }
}
