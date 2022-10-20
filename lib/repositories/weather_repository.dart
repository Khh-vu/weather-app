import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String cityName) async {
    final uri = _buildUri(
      path: 'data/2.5/weather',
      queryParameters: {'q': cityName},
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: ${response.reasonPhrase}');
    }
    final Map<String, dynamic> weatherJson = jsonDecode(response.body);

    if (weatherJson.isEmpty) {
      throw Exception('Cannot get the weather of the city');
    }

    return Weather.fromJson(weatherJson);
  }

  Uri _buildUri({
    required String path,
    required Map<String, String> queryParameters,
  }) {
    Map<String, String> query = {'appid': '0b3fdbf55c01964f9acb5b2e95f79241'};
    if (queryParameters.isNotEmpty) {
      query = query..addAll(queryParameters);
    }

    final uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: path,
      queryParameters: query,
    );

    log('Fetching $uri');

    return uri;
  }
}
