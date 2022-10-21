part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

enum TemperatureUnits { fahrenheit, celsius, kelvin }

extension TemperatureUnitsEx on TemperatureUnits {
  String temperature(num value) {
    switch (this) {
      case TemperatureUnits.fahrenheit:
        return '${((value - 273.15) * 1.8 + 32).toStringAsFixed(2)} °F';
      case TemperatureUnits.celsius:
        return '${(value - 273.15).toStringAsFixed(2)} °C';
      case TemperatureUnits.kelvin:
        return '$value K';
    }
  }
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits units;
  final String error;

  const WeatherState({
    required this.status,
    required this.weather,
    required this.units,
    required this.error,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    TemperatureUnits? units,
    String? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      units: units ?? this.units,
      error: error ?? this.error,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: Weather.initial(),
      units: TemperatureUnits.celsius,
      error: '',
    );
  }
  @override
  List<Object?> get props => [status, weather, units, error];
}
