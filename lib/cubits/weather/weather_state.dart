part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final String error;

  const WeatherState({
    required this.status,
    required this.weather,
    required this.error,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    String? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: Weather.initial(),
      error: '',
    );
  }
  @override
  List<Object?> get props => [status, weather, error];

  @override
  bool? get stringify => true;
}
