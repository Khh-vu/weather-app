import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/weather.dart';
import '../../repositories/weather_repository.dart';
import '../../services/search_service.dart';

part 'weather_state.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => WeatherRepository(),
);

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)),
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final WeatherRepository _weatherRepository;

  WeatherNotifier(this._weatherRepository) : super(WeatherState.initial()) {
    getTempUnits();
    fetchWeather();
  }

  Future<void> fetchWeather([String? cityName]) async {
    state = state.copyWith(status: WeatherStatus.loading);

    try {
      Weather weather;

      if (cityName != null) {
        weather = await _weatherRepository.fetchWeather(cityName);
      }
      final lastSearchCity = await SearchHistoryService().getSearchHistory();

      if (lastSearchCity.isNotEmpty) {
        weather = await _weatherRepository.fetchWeather(lastSearchCity.first);
      } else {
        weather = await _weatherRepository.fetchWeather('Hanoi');
      }
      state = state.copyWith(status: WeatherStatus.loaded, weather: weather);
    } on Exception catch (e) {
      state = state.copyWith(status: WeatherStatus.error, error: e.toString());
    }
  }

  void getTempUnits() async {
    final prefs = await _prefs;
    final data = prefs.getString('temp_units');

    if (data != null) {
      state = state.copyWith(units: TemperatureUnits.values.byName(data));
    }
  }

  void changeUnits(TemperatureUnits? units) async {
    if (units == null) return;
    final prefs = await _prefs;
    await prefs.setString('temp_units', units.name);
    state = state.copyWith(units: units);
  }
}
