import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';
import '../api_key/weather_api_key.dart';

class WeatherApiClient {
  Future<Weather> getCurrentWeather({required String location}) async {
    final Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> weatherJson = jsonDecode(response.body);

      return Weather.fromJson(weatherJson);
    } else {
      throw Exception('Failed to get data!');
    }
  }
}
