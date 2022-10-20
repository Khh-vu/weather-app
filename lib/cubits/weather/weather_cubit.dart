import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/weather.dart';
import '../../repositories/weather_repository.dart';
import '../../services/search_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather([String? cityName]) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      Weather weather;

      if (cityName != null) {
        weather = await weatherRepository.fetchWeather(cityName);
      }
      final lastSearchCity = await SearchHistoryService().getSearchHistory();

      if (lastSearchCity.isNotEmpty) {
        weather = await weatherRepository.fetchWeather(lastSearchCity.first);
      } else {
        weather = await weatherRepository.fetchWeather('Hanoi');
      }
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e.toString(),
      ));
    }
  }
}
