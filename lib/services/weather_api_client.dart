import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/weather.dart';
import '../constants/api_key.dart';

class WeatherApiClient {
  Uri _buildUri({
    required String path,
    required Map<String, String> queryParameters,
  }) {
    Map<String, String> query = {'appid': apiKey};
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

  Future<Weather> getWeather({
    required String cityName,
  }) async {
    final uri = _buildUri(
      path: 'data/2.5/weather',
      queryParameters: {'q': cityName},
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: Failed to get data!');
    }
    final Map<String, dynamic> weatherJson = jsonDecode(response.body);

    return Weather.fromJson(weatherJson);
  }

  Future<String> getCurrentCity({
    required double lat,
    required double lon,
  }) async {
    final uri = _buildUri(
      path: 'geo/1.0/reverse',
      queryParameters: {
        'lat': lat.toStringAsFixed(4),
        'lon': lon.toStringAsFixed(4),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: Failed to get data!');
    }
    final locationJson = jsonDecode(response.body) as List<dynamic>;

    return '${locationJson[0]['name']}, ${locationJson[0]['country']}';
  }
}
