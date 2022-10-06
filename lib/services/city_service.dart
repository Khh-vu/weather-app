import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/city.dart';

class CityService {
  static Future<List<City>> getCityList() async {
    final cityJson = await rootBundle.loadString('assets/citylist.json');

    return compute(_decodeAndParseJson, cityJson);
  }

  static List<City> _decodeAndParseJson(String encodedJson) {
    final jsonData = jsonDecode(encodedJson) as List<dynamic>;

    final citySet = jsonData.map((json) => City.fromJson(json)).toSet()
      ..removeWhere((city) => city.city == '-');

    final cityList = citySet.toList();

    return cityList;
  }
}
